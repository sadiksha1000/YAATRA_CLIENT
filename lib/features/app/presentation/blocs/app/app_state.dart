part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated, loading }

class AppState extends Equatable {
  final AppStatus status;
  final bool isPassenger;
  final bool isAgent;
  final String activeRole;
  final User user;
  final String uid;
  final String phone;
  final String accessToken;

  const AppState._({
    required this.status,
    this.user = User.empty,
    this.isPassenger = false,
    this.isAgent = false,
    this.activeRole = 'conductor',
    this.accessToken = '',
    this.phone = '',
    this.uid = '',
  });

  AppState.authenticated(User user)
      : this._(
          status: AppStatus.authenticated,
          user: user,
          isPassenger: user.isPassenger,
          isAgent: user.isAgent,
          activeRole: user.activeRole,
          accessToken: user.accessToken,
          phone: user.phone,
          uid: user.uid,
        );

  const AppState.unauthenticated()
      : this._(
          status: AppStatus.unauthenticated,
        );
  const AppState.loading()
      : this._(
          status: AppStatus.loading,
        );

  @override
  List<Object> get props => [status, user];

  Map<String, dynamic> toMap() {
    return {
      'status': status.name,
      'isPassenger': isPassenger,
      'isAgent': isAgent,
      'activeRole': activeRole,
      'user': user.toMap(),
      'accessToken': accessToken,
      'phone': phone,
      'uid': uid,
    };
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState._(
      status: AppStatus.values.byName(map['status']),
      isPassenger: map['isPassenger'] ?? false,
      isAgent: map['isAgent'] ?? false,
      activeRole: map['activeRole'] ?? '',
      user: User.fromLocalMap(map['user']),
      accessToken: map['accessToken'],
      phone: map['phone'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppState.fromJson(String source) =>
      AppState.fromMap(json.decode(source));
}
