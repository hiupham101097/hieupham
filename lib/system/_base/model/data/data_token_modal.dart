// import 'package:object_mapper/object_mapper.dart';

// class DataTokenModal with Mappable {
//   String accessToken;
//   int? expireInSeconds;
//   String? encryptedAccessToken;

//   DataTokenModal(
//     this.accessToken, {
//     this.expireInSeconds,
//     this.encryptedAccessToken,
//   });

//   @override
//   void mapping(Mapper map) {
//     map("accessToken", accessToken, (v) => accessToken = v);
//     map("expireInSeconds", expireInSeconds, (v) => expireInSeconds = v);
//     map("encryptedAccessToken", encryptedAccessToken,
//         (v) => encryptedAccessToken = v);
//   }

//   factory DataTokenModal.fromJson(Map<String, dynamic>? jsonInput) {
//     if (jsonInput == null) {
//       return DataTokenModal("");
//     }

//     var obj = Mapper.fromJson(jsonInput).toObject<DataTokenModal>();
//     return obj ?? DataTokenModal("");
//   }

//   Map<String, dynamic> toMap() {
//     // ignore: unnecessary_this
//     return this.toJson();
//   }
// }
