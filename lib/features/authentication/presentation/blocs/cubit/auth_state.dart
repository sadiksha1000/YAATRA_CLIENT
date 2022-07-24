part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, success, error }

enum OtpStatus { initial, loading, success, error }

class AuthState extends Equatable {
  final AuthStatus registerStatus;
  final UserModel user;
  final int otp;
  final String successMessage;
  final String errorMessage;
  final OtpStatus otpStatus;
  final AuthStatus loginStatus;
  final AuthStatus currentUserStatus;
  const AuthState({
    required this.registerStatus,
    required this.otp,
    required this.user,
    required this.errorMessage,
    required this.otpStatus,
    required this.successMessage,
    required this.loginStatus,
    required this.currentUserStatus,
  });

  factory AuthState.initial() => const AuthState(
        registerStatus: AuthStatus.initial,
        user: UserModel.empty,
        otp: 0,
        errorMessage: '',
        otpStatus: OtpStatus.initial,
        successMessage: '',
        loginStatus: AuthStatus.initial,
        currentUserStatus: AuthStatus.initial,
      );

  AuthState copyWith({
    AuthStatus? registerStatus,
    UserModel? user,
    int? otp,
    String? errorMessage,
    OtpStatus? otpStatus,
    String? successMessage,
    AuthStatus? loginStatus,
    AuthStatus? currentUserStatus,
  }) {
    return AuthState(
      registerStatus: registerStatus ?? this.registerStatus,
      user: user ?? this.user,
      otp: otp ?? this.otp,
      otpStatus: otpStatus ?? this.otpStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      loginStatus: loginStatus ?? this.loginStatus,
      currentUserStatus: currentUserStatus ?? this.currentUserStatus,
    );
  }

  @override
  List<Object> get props => [
        registerStatus,
        user,
        otp,
        errorMessage,
        otpStatus,
        successMessage,
        loginStatus,
        currentUserStatus,
      ];

  /// {registerStatus: loading, user: {uid: "dfksjk", name: "dskjfsk"}}
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

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      registerStatus: AuthStatus.values.byName(map['registerStatus']),
      user: UserModel.fromLocalMap(map['user']),
      otp: map['otp']?.toInt() ?? 0,
      successMessage: map['successMessage'] ?? '',
      errorMessage: map['errorMessage'] ?? '',
      otpStatus: OtpStatus.values.byName(map['otpStatus']),
      loginStatus: AuthStatus.values.byName(map['loginStatus']),
      currentUserStatus: AuthStatus.values.byName(map['currentUserStatus']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthState.fromJson(String source) =>
      AuthState.fromMap(json.decode(source));
}
