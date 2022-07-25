import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yaatra_client/core/utils/status.dart';
import 'package:yaatra_client/features/authentication/data/models/otp_response_model.dart';
import 'package:yaatra_client/features/authentication/domain/usecases/verify_sent_otp_to_phone_usecase.dart';

import '../../../../../../core/utils/input_converter.dart';
import '../../../../../../core/utils/input_validator.dart';
import '../../../../../core/network/network_info.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/usecases/login_user_usecase.dart';
import '../../../domain/usecases/refresh_current_user.dart';
import '../../../domain/usecases/register_user_usecase.dart';
import '../../../domain/usecases/send_otp_to_phone_usecase.dart';
import '../../../domain/usecases/switch_user_role_usecase.dart';

part 'auth_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a valid phone number';

class AuthCubit extends HydratedCubit<AuthState> with InputValidatorMixin {
  // dispose call
  RegisterUserUseCase registerUserUseCase;
  InputConverter inputConverter;
  InputValidator inputValidator;
  SendOTPToPhoneUseCase sendOTPToPhoneUseCase;
  VerifySentOTPToPhoneUseCase verifySentOTPToPhoneUseCase;
  LoginUserUseCase loginUserUseCase;
  RefreshCurrentUserUseCase refreshCurrentUserUseCase;
  SwitchUserRoleUseCase switchUserRoleUseCase;
  NetworkInfo networkInfo;

  AuthCubit({
    required RegisterUserUseCase registerUseCase,
    required InputConverter inputCon,
    required SendOTPToPhoneUseCase sendOTPUseCase,
    required VerifySentOTPToPhoneUseCase verifyOtpUseCase,
    required InputValidator inputValid,
    required LoginUserUseCase loginUseCase,
    required RefreshCurrentUserUseCase refreshCurrentUser,
    required SwitchUserRoleUseCase switchUserRole,
    required NetworkInfo networkIn,
  })  : registerUserUseCase = registerUseCase,
        inputConverter = inputCon,
        sendOTPToPhoneUseCase = sendOTPUseCase,
        inputValidator = inputValid,
        loginUserUseCase = loginUseCase,
        refreshCurrentUserUseCase = refreshCurrentUser,
        switchUserRoleUseCase = switchUserRole,
        networkInfo = networkIn,
        verifySentOTPToPhoneUseCase = verifyOtpUseCase,
        super(AuthState.initial());

  get emitInitialState {
    emit(AuthState.initial());
  }

  get emitInitialStatusState {
    emit(state.copyWith(
      otpStatus: OtpStatus.initial,
      loginStatus: AuthStatus.initial,
      registerStatus: AuthStatus.initial,
      currentUserStatus: AuthStatus.initial,
      verifyOtpStatus: Status.initial,
    ));
  }

  // Streams
  final _phoneNumberController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();
  final _otpController = BehaviorSubject<String>();

  // Sinks
  Function(String) get phoneNumberChanged => _phoneNumberController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;
  Function(String) get confirmPasswordChanged =>
      _confirmPasswordController.sink.add;
  Function(String) get otpChanged => _otpController.sink.add;

  // Getters
  Stream<String> get phoneNumber =>
      _phoneNumberController.stream.transform(phoneValidator);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);
  Stream<String> get confirmPassword =>
      _confirmPasswordController.stream.transform(passwordValidator);
  Stream<String> get otp => _otpController.stream.transform(otpValidator);

// check is valid
  // check phone number is valid
  Stream<bool> get isPhoneNumberValid =>
      Rx.combineLatest2(phoneNumber, phoneNumber, (a, b) => true);

  Stream<bool> get isLoginFormValid =>
      Rx.combineLatest2(phoneNumber, password, (a, b) => true);

  Stream<bool> get isOTPValid => Rx.combineLatest2(otp, otp, (a, b) => true);

  Stream<bool> get isPasswordValid =>
      Rx.combineLatest2(password, confirmPassword, (a, b) => true);

  void cancelLogin() {
    emit(state.copyWith(loginStatus: AuthStatus.initial));
  }

  Stream<bool> get isPasswordMatched async* {
    if (_passwordController.value == _confirmPasswordController.value) {
      yield true;
    } else {
      yield false;
    }
  }

  // dispose
  void dispose() {
    _phoneNumberController.close();
    _passwordController.close();
    _confirmPasswordController.close();
    _otpController.close();
  }

  void cancelRegistration() {
    emit(state.copyWith(
      registerStatus: AuthStatus.initial,
      otpStatus: OtpStatus.initial,
      verifyOtpStatus: Status.initial,
    ));
  }

  void registerUserWithPhoneAndPassword() {
    if (state.registerStatus == AuthStatus.loading) return;
    emit(state.copyWith(registerStatus: AuthStatus.loading));
    final inputEither =
        inputValidator.validatePhoneNumber(_phoneNumberController.value);
    inputEither.fold(
      (failure) => emit(state.copyWith(
          errorMessage: INVALID_INPUT_FAILURE_MESSAGE,
          registerStatus: AuthStatus.error)),
      (result) async {
        final otpEither = await registerUserUseCase(
          password: _passwordController.value,
          phone: _phoneNumberController.value,
        );
        otpEither.fold(
          (failure) => emit(state.copyWith(
              errorMessage: failure.message, registerStatus: AuthStatus.error)),
          (user) {
            emit(state.copyWith(
                user: user as UserModel, registerStatus: AuthStatus.success));
          },
        );
      },
    );
  }

  Future<void> otpVerified() async {
    emit(state.copyWith(verifyOtpStatus: Status.loading));
    final otpEither = await verifySentOTPToPhoneUseCase(
      phone: _phoneNumberController.value,
      otp: _otpController.value,
      hash: state.otpResponse.hash,
    );
    otpEither.fold(
      (failure) => emit(state.copyWith(
          errorMessage: failure.message, verifyOtpStatus: Status.error)),
      (otpRes) {
        emit(state.copyWith(
            otpResponse: otpRes, verifyOtpStatus: Status.success));
      },
    );
  }

  void sendOTP() {
    if (state.otpStatus == OtpStatus.loading) return;
    emit(state.copyWith(otpStatus: OtpStatus.loading));
    final inputEither =
        inputValidator.validatePhoneNumber(_phoneNumberController.value);
    inputEither.fold(
      (failure) => emit(state.copyWith(
          errorMessage: INVALID_INPUT_FAILURE_MESSAGE,
          otpStatus: OtpStatus.error)),
      (result) async {
        final otpEither =
            await sendOTPToPhoneUseCase(phone: _phoneNumberController.value);
        otpEither.fold(
            (failure) => emit(state.copyWith(
                errorMessage: SERVER_FAILURE_MESSAGE,
                otpStatus: OtpStatus.error)), (otpRes) {
          emit(state.copyWith(
              otpResponse: otpRes, otpStatus: OtpStatus.success));
        });
      },
    );
  }

  // Login methods
  void login() async {
    if (await networkInfo.isConnected) {
      if (state.loginStatus == AuthStatus.loading) return;

      emit(state.copyWith(loginStatus: AuthStatus.loading));
      final inputEither =
          inputValidator.validatePhoneNumber(_phoneNumberController.value);
      inputEither.fold(
        (failure) => emit(state.copyWith(
            errorMessage: INVALID_INPUT_FAILURE_MESSAGE,
            loginStatus: AuthStatus.error)),
        (result) async {
          final loginEither = await loginUserUseCase(
              phone: _phoneNumberController.value,
              password: _passwordController.value);
          loginEither.fold(
              (failure) => emit(state.copyWith(
                  errorMessage: failure.message,
                  loginStatus: AuthStatus.error)), (user) {
            emit(state.copyWith(
                user: user as UserModel, loginStatus: AuthStatus.success));
          });
        },
      );
    } else {
      emit(state.copyWith(
          loginStatus: AuthStatus.error,
          errorMessage: "Please connect with internet and try again."));
    }
  }

  // refresh current user
  void refreshCurrentUser() async {
    if (state.currentUserStatus == AuthStatus.loading) return;
    emit(state.copyWith(currentUserStatus: AuthStatus.loading));

    final currentUserEither = await refreshCurrentUserUseCase.execute(
      uid: state.user.uid,
    );
    currentUserEither.fold(
        (failure) => emit(
              state.copyWith(
                  errorMessage: failure.message,
                  currentUserStatus: AuthStatus.error),
            ), (user) {
      emit(
        state.copyWith(
            user: user as UserModel, currentUserStatus: AuthStatus.success),
      );
    });
  }

  // refresh current user
  void switchUserRole(String activeRole) async {
    // if (state.loginStatus == AuthStatus.loading) return;

    emit(state.copyWith(
      loginStatus: AuthStatus.loading,
    ));
    final switchUserRole = await switchUserRoleUseCase(
      uid: state.user.uid,
      activeRole: activeRole,
    );
    switchUserRole.fold(
        (failure) => emit(
              state.copyWith(
                  errorMessage: failure.message, loginStatus: AuthStatus.error),
            ), (user) {
      emit(
        state.copyWith(
            user: user as UserModel, loginStatus: AuthStatus.success),
      );
    });
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromMap(json);
    // try {
    //   if (state.loginStatus == AuthStatus.success) {
    //   } else {
    //     return AuthState.initial();
    //   }
    // } catch (_) {
    //   return AuthState.initial();
    // }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toMap();
    // try {
    // } catch (_) {
    //   return null;
    // }
  }
}
