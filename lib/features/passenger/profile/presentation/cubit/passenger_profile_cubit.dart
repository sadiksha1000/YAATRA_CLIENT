import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yaatra_client/core/network/network_info.dart';
import 'package:yaatra_client/core/utils/input_validator.dart';
import 'package:yaatra_client/features/passenger/profile/domain/usecases/create_passenger_profile_usecase.dart';
import 'package:yaatra_client/features/passenger/profile/domain/usecases/get_passenger_usecase.dart';

import '../../../../../core/utils/status.dart';
import '../../../../app/presentation/blocs/app/app_bloc.dart';
import '../../../../authentication/domain/entities/user.dart';
import '../../data/models/passenger_profile_model.dart';
import '../../domain/enities/passenger_profile.dart';

part 'passenger_profile_state.dart';

class PassengerProfileCubit extends Cubit<PassengerProfileState>
    with InputValidatorMixin {
  GetCurrentPassengerUsecase getCurrentPassengerUsecase;
  NetworkInfo networkInfo;
  CreateProfileUseCase createProfileUseCase;

  PassengerProfileCubit(
      {required NetworkInfo networkInfo,
      required GetCurrentPassengerUsecase getCurrentPassenger,
      required CreateProfileUseCase createProfileUseCase})
      : networkInfo = networkInfo,
        getCurrentPassengerUsecase = getCurrentPassenger,
        createProfileUseCase = createProfileUseCase,
        super(PassengerProfileState.initial());

  PassengerProfile _currentPassenger = PassengerProfile.empty;
  void setCurrentPassenger(PassengerProfile passenger) {
    _currentPassenger = passenger;
  }

//Streams
  final _nameController = BehaviorSubject<String>();
  final _profileUrlController = BehaviorSubject<String>();
  final _addressController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();

//Sinks
  Function(String) get createdname => _nameController.sink.add;
  Function(String) get createprofileUrl => _profileUrlController.sink.add;
  Function(String) get createdaddress => _addressController.sink.add;
  Function(String) get createdphone => _phoneController.sink.add;

// getter
  Stream<String> get name => _nameController.stream;
  Stream<String> get profileUrl => _profileUrlController.stream;
  Stream<String> get address => _addressController.stream;
  Stream<String> get phone => _phoneController.stream;

//dispose
  void dispose() {
    _nameController.close();
    _profileUrlController.close();
    _addressController.close();
    _phoneController.close();
  }

//validators
  Stream<bool> get submitValid =>
      Rx.combineLatest4(name, profileUrl, address, phone, (a, b, c, d) => true);

  Stream<bool> get isNameValid => Rx.combineLatest2(name, name, (a, b) => true);
  Stream<bool> get isProfileUrlValid =>
      Rx.combineLatest2(profileUrl, profileUrl, (a, b) => true);
  Stream<bool> get isAddressValid =>
      Rx.combineLatest2(address, address, (a, b) => true);
  Stream<bool> get isPhoneValid =>
      Rx.combineLatest2(phone, phone, (a, b) => true);

  // @override
  // void didChangeDependencies() async {
  //   User _user = await _userCubit.getCurrentUser(
  //     BlocProvider.of<AppBloc>(context).state.user.uid,
  //   );
  //   super.didChangeDependencies();
  // }

  Future<void> createProfile({PassengerProfile? passengerdata}) async {
    emit(state.copyWith(saveProfileStatus: Status.loading));
    if (await networkInfo.isConnected) {
      PassengerProfile passengerProfile = PassengerProfile(
        uid: state.currentCreatedProfile.uid,
        pId: state.currentCreatedProfile.pId,
        name: _nameController.valueOrNull ?? '',
        phone: _phoneController.valueOrNull ?? '',
        profileUrl: _profileUrlController.valueOrNull ?? '',
        address: _addressController.valueOrNull ?? '',
        message: '',
      );
      print("Passenger profile Id ${passengerProfile}");

      final passengerDraft = await createProfileUseCase(passengerProfile);
      print("PassengerDraft$passengerDraft");
      passengerDraft.fold(
        (failure) => emit(state.copyWith(
            saveProfileStatus: Status.error, errorMessage: failure.message)),
        (passengerProfile) => emit(
          state.copyWith(
              saveProfileStatus: Status.success,
              successMessage: passengerProfile.message,
              currentCreatedProfile: passengerProfile),
        ),
      );
    } else {
      emit(state.copyWith(
        networkStatus: Status.noNetwork,
        errorMessage: 'Please connect with Internet',
      ));
    }
  }

  Future<void> fetchProfile(String profileId) async {
    if (await networkInfo.isConnected) {
      emit(state.copyWith(status: Status.loading));
      final result = await getCurrentPassengerUsecase(uid: profileId);
      result.fold(
          (failure) => emit(state.copyWith(
              status: Status.error, errorMessage: failure.message)), (profile) {
        emit(state.copyWith(
            currentCreatedProfile: profile, status: Status.success));
      });
    }
  }

  Future<void> refreshProfile() async {
    if (await networkInfo.isConnected) {
      final result = await getCurrentPassengerUsecase(
          uid: state.currentCreatedProfile.uid.uid);
      result.fold((failure) => emit(state), (profile) {
        emit(state.copyWith(currentCreatedProfile: profile));
      });
    }
  }

  Future<PassengerProfile> getCurrentPassenger(String uid) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final passengerEither = await getCurrentPassengerUsecase(uid: uid);
      passengerEither.fold(
          (failure) => emit(state.copyWith(
              status: Status.error,
              errorMessage: failure.message)), (passenger) {
        setCurrentPassenger(passenger);
        emit(state.copyWith(
            currentCreatedProfile: passenger as PassengerProfileModel,
            status: Status.success,
            successMessage: passenger.message));
      });
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
    return _currentPassenger;
  }
}
