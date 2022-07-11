part of 'apply_as_agent_cubit.dart';

class ApplyAsAgentState extends Equatable {
  final bool isApplied;
  final AgentModel agent;
  final Status status;
  final String errorMessage;
  final String successMessage;

  const ApplyAsAgentState({
    required this.status,
    required this.isApplied,
    required this.agent,
    required this.errorMessage,
    required this.successMessage,
  });

  @override
  List<Object> get props => [
        status,
        isApplied,
        agent,
        errorMessage,
        successMessage,
      ];

  factory ApplyAsAgentState.initial() => ApplyAsAgentState(
        status: Status.initial,
        isApplied: false,
        agent: AgentModel.empty,
        errorMessage: '',
        successMessage: '',
      );

  ApplyAsAgentState copyWith({
    Status? status,
    String? errorMessage,
    String? successMessage,
    AgentModel? agent,
    bool? isApplied,
  }) {
    return ApplyAsAgentState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      agent: agent ?? this.agent,
      isApplied: isApplied ?? this.isApplied,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status.index,
      'errorMessage': errorMessage,
      'successMessage': successMessage,
      'agent': agent.toMap(),
      'isApplied': isApplied,
    };
  }

  factory ApplyAsAgentState.fromMap(Map<String, dynamic> map) {
    return ApplyAsAgentState(
      status: Status.values[map['status']],
      errorMessage: map['errorMessage'],
      successMessage: map['successMessage'],
      agent: AgentModel.fromMap(map['agent']),
      isApplied: map['isApplied'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApplyAsAgentState.fromJson(String jsonString) {
    return ApplyAsAgentState.fromMap(json.decode(jsonString));
  }
}
