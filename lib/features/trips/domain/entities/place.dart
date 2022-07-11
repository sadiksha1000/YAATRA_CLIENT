import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String pid;
  final String name;

  const Place({
    required this.pid,
    required this.name,
  });

  static const empty = Place(
    pid: '',
    name: '',
  );

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      pid: map['_id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': pid,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [pid, name];
}
