import 'location.dart';

class User {
  String? id;
  String? name;
  String? email;
  String? role;
  String? region;
  int? age;
  String? gender;
  String? signUpPlatform;
  List<String>? favoriteProviders;
  bool? verified;
  List<Location>? locations;
  int? v;
  String? phoneNumber;
  String? photo;
  User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.region,
    this.age,
    this.gender,
    this.signUpPlatform,
    this.favoriteProviders,
    this.verified,
    this.locations,
    this.v,
    this.phoneNumber,
    this.photo, // إضافة photo إلى المُنشئ
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        role: json['role'] as String?,
        region: json['region'] as String?,
        age: json['age'] as int?,
        gender: json['gender'] as String?,
        signUpPlatform: json['signUpPlatform'] as String?,
        favoriteProviders: (json['favoriteProviders'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(), // تحويل كل عنصر إلى String
        verified: json['verified'] as bool?,
        locations: (json['locations'] as List<dynamic>?)
            ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
            .toList(),
        v: json['__v'] as int?,
        phoneNumber: json['phoneNumber'] as String?,
        photo: json['photo'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'role': role,
        'region': region,
        'age': age,
        'gender': gender,
        'signUpPlatform': signUpPlatform,
        'favoriteProviders': favoriteProviders,
        'verified': verified,
        'locations': locations?.map((e) => e.toJson()).toList(),
        '__v': v,
        'phoneNumber': phoneNumber,
        'photo': photo, // إضافة photo إلى toJson
      };
}
