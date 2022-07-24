// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';
// import '../../domain/entities/user.dart';

// import '../../../../../core/errors/exception.dart';
// import '../models/user_model.dart';

// const CACHED_USER_DETAILS = 'CACHED_USER_DETAILS';
// const CACHED_OTP = 'CACHED_OTP';

// abstract class UserLocalDataSource {
//   /// Throws [CacheException] if no cache data is stored
//   Future<int?> getLastOTP();
//   Future<void> cacheOTP(int otp);
//   Future<UserModel> getLastUserDetails();
//   Future<void> cacheUserDetails(UserModel userDetails);
// }

// class UserLocalDataSourceImpl implements UserLocalDataSource {
//   final SharedPreferences sharedPreferences;
//   UserLocalDataSourceImpl({
//     required this.sharedPreferences,
//   });

//   @override
//   Future<void> cacheOTP(int otp) {
//     return sharedPreferences.setInt(CACHED_OTP, otp);
//   }

//   @override
//   Future<void> cacheUserDetails(UserModel userDetails) {
//     return sharedPreferences.setString(
//         CACHED_USER_DETAILS, json.encode(userDetails.toJson()));
//   }

//   @override
//   Future<int?> getLastOTP() async {
//     return sharedPreferences.getInt(CACHED_OTP);
//   }

//   @override
//   Future<UserModel> getLastUserDetails() async {
//     final jsonString = sharedPreferences.getString(CACHED_USER_DETAILS);
//     if (jsonString != null) {
//       return Future.value(UserModel.fromMap(json.decode(jsonString)));
//     } else {
//       return UserModel.empty;
//     }
//   }
// }
