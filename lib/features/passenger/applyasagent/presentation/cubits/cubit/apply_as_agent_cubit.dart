import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../core/utils/input_validator.dart';
import '../../../domain/usecases/refresh_apply_as_agent_usecase.dart';

import '../../../../../../core/network/network_info.dart';
import '../../../../../../core/utils/status.dart';
import '../../../data/models/agent_model.dart';
import '../../../domain/usecases/apply_as_agent_usecase.dart';

part 'apply_as_agent_state.dart';

class ApplyAsAgentCubit extends HydratedCubit<ApplyAsAgentState>
    with InputValidatorMixin {
  NetworkInfo networkInfo;
  ApplyAsAgentUseCase applyAsAgentUseCase;
  RefreshApplyAsAgentUseCase refreshApplyAsAgentUseCase;

  ApplyAsAgentCubit({
    required NetworkInfo networkInfo,
    required ApplyAsAgentUseCase applyAsAgentUseCase,
    required RefreshApplyAsAgentUseCase refreshApplyAsAgentUseCase,
  })  : networkInfo = networkInfo,
        applyAsAgentUseCase = applyAsAgentUseCase,
        refreshApplyAsAgentUseCase = refreshApplyAsAgentUseCase,
        super(ApplyAsAgentState.initial());

  // streams
  final _fullNameController = BehaviorSubject<String>();
  final _addressController = BehaviorSubject<String>();
  final _phoneNumberController = BehaviorSubject<String>();
  final _documentUrlController = BehaviorSubject<List<String>>();

  // sinks
  Function(String) get fullNameChanged => _fullNameController.sink.add;
  Function(String) get addressChanged => _addressController.sink.add;
  Function(String) get phoneNumberChanged => _phoneNumberController.sink.add;
  Function(List<String>) get documentUrlChanged =>
      _documentUrlController.sink.add;

  // getters
  Stream<String> get fullName =>
      _fullNameController.stream.transform(emptyValidator);
  Stream<String> get address =>
      _addressController.stream.transform(emptyValidator);
  Stream<String> get phoneNumber =>
      _phoneNumberController.stream.transform(phoneValidator);
  Stream<List<String>> get documentUrl => _documentUrlController.stream;

  // validators
  Stream<bool> get isApplyFormValid => Rx.combineLatest3(
        fullName,
        address,
        phoneNumber,
        (a, b, c) => true,
      );

  Stream<bool> get isFullNameValid =>
      Rx.combineLatest2(fullName, fullName, (a, b) => true);
  Stream<bool> get isAddressValid =>
      Rx.combineLatest2(address, address, (a, b) => true);
  Stream<bool> get isPhoneValid =>
      Rx.combineLatest2(phoneNumber, phoneNumber, (a, b) => true);
  Stream<bool> get isDocumentValid =>
      Rx.combineLatest2(documentUrl, documentUrl, (a, b) => true);

  Future<void> applyAsAgent(String uid) async {
    var applyEither = await applyAsAgentUseCase(
      address: _addressController.value,
      documentUrl: _documentUrlController.value,
      name: _fullNameController.value,
      phone: _phoneNumberController.value,
      uid: uid,
    );
    applyEither.fold(
      (failure) => {
        emit(state.copyWith(
          status: Status.error,
          errorMessage: failure.message,
        ))
      },
      (success) => {
        emit(state.copyWith(
          status: Status.success,
          agent: success as AgentModel,
          successMessage: "Applied for agent successfully",
          isApplied: true,
        ))
      },
    );
  }

  // refresh state

  Future<void> refreshState(String uid) async {
    if (await networkInfo.isConnected) {
      var applyEither = await refreshApplyAsAgentUseCase(
        aid: uid,
      );
      applyEither.fold(
        (failure) => {
          emit(state.copyWith(
            status: Status.error,
            errorMessage: failure.message,
            isApplied: false,
          ))
        },
        (success) => {
          emit(state.copyWith(
            status: Status.success,
            agent: success as AgentModel,
            successMessage: "Fetched Successfully",
            isApplied: true,
          ))
        },
      );
    } else {
      emit(
        state.copyWith(
          status: Status.noNetwork,
          errorMessage: "Please connect with internet",
        ),
      );
    }
  }

  @override
  ApplyAsAgentState? fromJson(Map<String, dynamic> json) {
    return ApplyAsAgentState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ApplyAsAgentState state) {
    return state.toMap();
  }
}
