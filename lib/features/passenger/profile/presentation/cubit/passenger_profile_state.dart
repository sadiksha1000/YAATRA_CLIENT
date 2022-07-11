part of 'passenger_profile_cubit.dart';

class PassengerProfileState extends Equatable {
  final Status status;
  final PassengerProfile fetchProfile;
  final String errorMessage;
  final String successMessage;
  final Status saveProfileStatus;
  final PassengerProfile currentCreatedProfile;
  final Status networkStatus;

  const PassengerProfileState({
    required this.fetchProfile,
    required this.status,
    required this.errorMessage,
    required this.successMessage,
    required this.saveProfileStatus,
    required this.currentCreatedProfile,
    required this.networkStatus,
  });

  @override
  List<Object> get props => [
        fetchProfile,
        status,
        errorMessage,
        successMessage,
        saveProfileStatus,
        currentCreatedProfile,
        networkStatus
      ];

  factory PassengerProfileState.initial() {
    return const PassengerProfileState(
        fetchProfile: PassengerProfile.empty,
        status: Status.initial,
        errorMessage: '',
        successMessage: '',
        saveProfileStatus: Status.initial,
        currentCreatedProfile: PassengerProfile.empty,
        networkStatus: Status.initial);
  }
  PassengerProfileState copyWith(
      {Status? status,
      String? errorMessage,
      PassengerProfile? fetchProfile,
      String? successMessage,
      Status? saveProfileStatus,
      Status? networkStatus,
      PassengerProfile? currentCreatedProfile}) {
    return PassengerProfileState(
      status: status ?? this.status,
      fetchProfile: fetchProfile ?? this.fetchProfile,
      errorMessage: errorMessage ?? this.errorMessage,
      networkStatus: networkStatus ?? this.networkStatus,
      successMessage: successMessage ?? this.successMessage,
      saveProfileStatus: saveProfileStatus ?? this.saveProfileStatus,
      currentCreatedProfile:
          currentCreatedProfile ?? this.currentCreatedProfile,
    );
  }
}
