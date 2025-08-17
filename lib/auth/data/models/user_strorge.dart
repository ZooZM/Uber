import 'package:hive/hive.dart';
import 'package:uber/constants.dart';

import 'curuser.dart';

class UserStorage {
  static Box<CurUser>? _box;

  static Future<void> init() async {
    if (_box != null) return;

    if (Hive.isBoxOpen(kCurUserBox)) {
      _box = Hive.box<CurUser>(kCurUserBox);
    } else {
      try {
        _box = await Hive.openBox<CurUser>(kCurUserBox);
      } catch (e) {
        final dir = Hive.boxExists(kCurUserBox);
        if (await dir) {
          await Hive.deleteBoxFromDisk(kCurUserBox);
        }

        _box = await Hive.openBox<CurUser>(kCurUserBox);
      }
    }
  }

  static Future<void> saveUserData({
    required String? token,
    required String? userId,
    required String? name,
    required String? email,
    required String? photo,
    required String? phoneNumber,
    required String? role,
    required String? nationalId,
    required String? vehicleType,
    required List<num>? coord,
    required bool? online,
  }) async {
    final user = CurUser(
      token: token ?? "unknown",
      userId: userId ?? "unknown",
      name: name ?? "unknown",
      email: email ?? "unknown@example.com",
      photo: photo ?? "default_photo_url",
      phoneNumber: phoneNumber ?? "unknown",
      role: role ?? "unknown",
      nationalId: nationalId ?? "unknown",
      vehicleType: vehicleType ?? "unknown",
      coord: coord ?? [0, 0],
      online: online ?? false,
    );

    await _box?.put(kCurUserBox, user);
  }

  static CurUser getUserData() {
    return _box?.get(kCurUserBox) ??
        CurUser(
          token: 'unknown',
          userId: 'unknown',
          name: 'unknown',
          email: 'unknown@example.com',
          photo: 'default_photo_url',
          phoneNumber: 'unknown',
          role: 'unknown',
          nationalId: 'unknown',
          vehicleType: 'unknown',
          coord: [0, 0],
          online: false,
        );
  }

  static Future<void> deleteUserData() async {
    await _box?.delete(kCurUserBox);
  }

  static Future<void> updateUserData({
    String? token,
    String? userId,
    String? name,
    String? email,
    String? photo,
    String? phoneNumber,
    String? role,
    String? nationalId,
    String? vehicleType,
    bool? isOnline,
    List<num>? coord,
  }) async {
    final user = getUserData();
    user.token = token ?? user.token;
    user.userId = userId ?? user.userId;
    user.name = name ?? user.name;
    user.email = email ?? user.email;
    user.photo = photo ?? user.photo;
    user.phoneNumber = phoneNumber ?? user.phoneNumber;
    user.role = role ?? user.role;
    user.nationalId = nationalId ?? user.nationalId;
    user.vehicleType = vehicleType ?? user.vehicleType;
    user.online = isOnline ?? user.online;
    user.coord = coord ?? user.coord;
    await _box?.put(kCurUserBox, user);
  }
}
