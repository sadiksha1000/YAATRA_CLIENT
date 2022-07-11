import 'package:equatable/equatable.dart';
import 'user.dart';

class Conductor extends Equatable {
  final String cid;
  final String name;
  final String address;
  final String photo;
  final User uid;

  const Conductor({
    required this.cid,
    required this.name,
    required this.address,
    required this.photo,
    required this.uid,
  });

  static const empty = Conductor(
    cid: '',
    name: '',
    address: '',
    photo: '',
    uid: User.empty,
  );

  factory Conductor.fromMap(Map<String, dynamic> map) {
    return Conductor(
      cid: map['_id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      photo: map['photo'] ?? '',
      uid: User.fromMap(map['uid']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': cid,
      'name': name,
      'address': address,
      'photo': photo,
      'uid': uid.toMap(),
    };
  }

  @override
  List<Object?> get props => [
        cid,
        name,
        address,
        photo,
        uid,
      ];
}
