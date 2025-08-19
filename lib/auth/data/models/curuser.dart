import 'package:hive/hive.dart';
part 'curuser.g.dart';

@HiveType(typeId: 0)
class CurUser extends HiveObject {
  @HiveField(0)
  String token;
  @HiveField(1)
  String userId;
  @HiveField(2)
  String name;
  @HiveField(3)
  String email;
  @HiveField(4)
  String photo;
  @HiveField(5)
  String phoneNumber;
  @HiveField(6)
  String role;
  @HiveField(7)
  String nationalId;
  @HiveField(8)
  String? vehicleType;
  @HiveField(9)
  bool online;
  @HiveField(10)
  List<double> coord;

  CurUser({
    required this.token,
    required this.userId,
    required this.name,
    required this.email,
    required this.photo,
    required this.phoneNumber,
    required this.role,
    required this.nationalId,
    required this.vehicleType,
    required this.online,
    required this.coord,
  });

  factory CurUser.fromJson(Map<String, dynamic> json) {
    return CurUser(
      token: json['token'] ?? '',
      userId: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photo: json['photo'] is String ? json['photo'] : '',
      phoneNumber: json['phoneNumber'] ?? '',
      role: json['role'] ?? '',
      nationalId: json['nationalId'] ?? '',
      vehicleType: json['vehicleType'] ?? '',
      online: json['online'] ?? false,
      coord:
          (json["location"]?["coordinates"] as List?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [0.0, 0.0],
    );
  }
}
