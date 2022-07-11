part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, success, error }

enum OtpStatus { initial, loading, success, error }

class AuthState extends Equatable {
  final AuthStatus registerStatus;
  final AuthStatus loginStatus;
  final OtpStatus otpStatus;
  final UserModel user;
  final int otp;
  final String successMessage;
  final String errorMessage;
  final AuthStatus currentUserStatus;

  const AuthState({
    required this.registerStatus,
    required this.loginStatus,
    required this.otpStatus,
    required this.user,
    required this.otp,
    required this.successMessage,
    required this.errorMessage,
    required this.currentUserStatus,
  });

  factory AuthState.initial() => const AuthState(
        registerStatus: AuthStatus.initial,
        loginStatus: AuthStatus.initial,
        otpStatus: OtpStatus.initial,
        user: UserModel.empty,
        otp: 0,
        successMessage: '',
        errorMessage: '',
        currentUserStatus: AuthStatus.initial,
      );

  AuthState copyWith({
    AuthStatus? registerStatus,
    AuthStatus? loginStatus,
    OtpStatus? otpStatus,
    UserModel? user,
    int? otp,
    String? successMessage,
    String? errorMessage,
    AuthStatus? currentUserStatus,
  }) {
    return AuthState(
      registerStatus: registerStatus ?? this.registerStatus,
      loginStatus: loginStatus ?? this.loginStatus,
      otpStatus: otpStatus ?? this.otpStatus,
      user: user ?? this.user,
      otp: otp ?? this.otp,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
      currentUserStatus: currentUserStatus ?? this.currentUserStatus,
    );
  }

  @override
  List<Object> get props => [
        registerStatus,
        loginStatus,
        otpStatus,
        user,
        otp,
        successMessage,
        errorMessage,
        currentUserStatus,
      ];

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      registerStatus: AuthStatus.values.byName(map['registerStatus']),
      user: UserModel.fromMap(map['user']),
      otp: map['otp']?.toInt() ?? 0,
      successMessage: map['successMessage'] ?? '',
      errorMessage: map['errorMessage'] ?? '',
      otpStatus: OtpStatus.values.byName(map['otpStatus']),
      loginStatus: AuthStatus.values.byName(map['loginStatus']),
      currentUserStatus: AuthStatus.values.byName(map['currentUserStatus']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'registerStatus': registerStatus.name,
      'user': user.toMap(),
      'otp': otp,
      'successMessage': successMessage,
      'errorMessage': errorMessage,
      'otpStatus': otpStatus.name,
      'loginStatus': loginStatus.name,
      'currentUserStatus': currentUserStatus.name,
    };
  }

  String toJson() => json.encode(toMap());

  factory AuthState.fromJson(String source) =>
      AuthState.fromMap(json.decode(source));
}
