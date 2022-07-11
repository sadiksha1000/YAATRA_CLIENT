import 'package:equatable/equatable.dart';

class Facilities extends Equatable {
  final String fid;
  final String iconName;
  final String facilityName;

  const Facilities({
    required this.fid,
    required this.iconName,
    required this.facilityName,
  });

  static const empty = Facilities(
    fid: '',
    iconName: '',
    facilityName: '',
  );

  factory Facilities.fromMap(Map<String, dynamic> map) {
    return Facilities(
      fid: map['_id'] ?? '',
      iconName: map['iconName'] ?? '',
      facilityName: map['facilityName'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': fid,
      'iconName': iconName,
      'facilityName': facilityName,
    };
  }

  @override
  List<Object?> get props => [
        fid,
        iconName,
        facilityName,
      ];
}
