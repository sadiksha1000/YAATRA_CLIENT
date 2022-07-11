import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../authentication/domain/repositories/user_repository.dart';

import '../../../../authentication/domain/entities/user.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> with HydratedMixin {
  final UserRepository _authRepository;
  StreamSubscription<User>? _userSubscription;

  AppBloc({required UserRepository authRepository})
      : _authRepository = authRepository,
        super(authRepository.currentUser.isNotEmpty
            ? AppState.authenticated(authRepository.currentUser)
            : const AppState.unauthenticated()) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
  }

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    // emit(const AppState.loading());
    print("before logout ${event.user}");
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
    print("after logout $state");
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    emit(const AppState.unauthenticated());
    unawaited(_authRepository.logout(state.user.uid));
  }

  @override
  Future<void> close() {
    _userSubscription!.cancel();
    return super.close();
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    try {
      if (state.status == AppStatus.authenticated) {}
      return AppState.fromMap(json);
    } catch (e) {
      print("this is fromjson app bloc error $e");
    }
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    try {
      if (state.status == AppStatus.loading) {}
      return state.toMap();
    } catch (e) {
      print("this is toJson app bloc error $e");
    }
  }
}
