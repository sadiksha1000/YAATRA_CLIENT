import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../core/utils/input_validator.dart';
import '../../../domain/usecases/login_user_usecase.dart';
import '../../../domain/usecases/register_user_usecase.dart';
import '../../../../bus/domain/usecases/fetch_allbuses_usecase.dart';
import '../../../../bus/domain/usecases/fetch_stations_usecase.dart';
import '../../../../../core/utils/input_converter.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/usecases/refresh_current_user.dart';
import '../../../domain/usecases/send_otp_to_phone_usecase.dart';
import '../../../domain/usecases/switch_user_role_usecase.dart';

part 'auth_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a valid phone number';

class AuthCubit extends HydratedCubit<AuthState> with InputValidatorMixin {
  RegisterUserUseCase registerUserUseCase;
  SendOTPToPhoneUseCase sendOTPToPhoneUseCase;
  InputConverter inputConverter;
  InputValidator inputValidator;
  LoginUserUseCase loginUserUseCase;
  RefreshCurrentUserUseCase refreshCurrentUserUseCase;
  SwitchUserRoleUseCase switchUserRoleUseCase;

  AuthCubit({
    required RegisterUserUseCase registerUseCase,
    required SendOTPToPhoneUseCase sendOTPUseCase,
    required InputConverter inputConverter,
    required InputValidator inputValidator,
    required LoginUserUseCase loginUseCase,
    required RefreshCurrentUserUseCase refreshCurrentUser,
    required SwitchUserRoleUseCase switchUserRole,
  })  : registerUserUseCase = registerUseCase,
        sendOTPToPhoneUseCase = sendOTPUseCase,
        inputConverter = inputConverter,
        inputValidator = inputValidator,
        loginUserUseCase = loginUseCase,
        refreshCurrentUserUseCase = refreshCurrentUser,
        switchUserRoleUseCase = switchUserRole,
        super(AuthState.initial());

  // Streams
  final _phoneNumberController = BehaviorSubject<String>();
  final _otpController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();

  // Sinks
  Function(String) get phoneNumberChanged => _phoneNumberController.sink.add;
  Function(String) get otpChanged => _otpController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;
  Function(String) get confirmPasswordChanged =>
      _confirmPasswordController.sink.add;

  // Getters
  Stream<String> get phoneNumber =>
      _phoneNumberController.stream.transform(phoneValidator);
  Stream<String> get otp => _otpController.stream.transform(otpValidator);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);
  Stream<String> get confirmPassword =>
      _confirmPasswordController.stream.transform(passwordValidator);

  Stream<bool> get isPhoneNumberValid =>
      Rx.combineLatest2(phoneNumber, phoneNumber, (a, b) => true);

  Stream<bool> get isLoginFormValid =>
      Rx.combineLatest2(phoneNumber, phoneNumber, (a, b) => true);

  Stream<bool> get isOTPValid => Rx.combineLatest2(otp, otp, (a, b) => true);

  Stream<bool> get isPasswordValid =>
      Rx.combineLatest2(password, confirmPassword, (a, b) => true);

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
            dispose();
            emit(state.copyWith(
                user: user as UserModel, registerStatus: AuthStatus.success));
          },
        );
      },
    );
  }

  bool otpVerified() {
    if (state.otp.toString() == _otpController.value) {
      return true;
    } else {
      return false;
    }
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
                otpStatus: OtpStatus.error)), (otp) {
          emit(state.copyWith(otp: otp, otpStatus: OtpStatus.success));
        });
      },
    );
  }

  // Login methods
  void login() {
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
        print("LoginEither$loginEither");
        loginEither.fold(
            (failure) => emit(state.copyWith(
                errorMessage: failure.message,
                loginStatus: AuthStatus.error)), (user) {
          print("User at auth login cubit $user");
          emit(state.copyWith(
              user: user as UserModel, loginStatus: AuthStatus.success));
        });
      },
    );
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
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toMap();
  }
}
