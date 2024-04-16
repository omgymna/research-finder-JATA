// class UserModel {
//   String? sId;
//   UserId? userId;
//   String? name;
//   String? university;
//   String? profilePic;
//   String? createdAt;
//   String? updatedAt;
//
//   UserModel(
//       {this.sId,
//         this.userId,
//         this.name,
//         this.university,
//         this.profilePic,
//         this.createdAt,
//         this.updatedAt});
//
//   UserModel.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     userId =
//     json['user_id'] != null ? UserId.fromJson(json['user_id']) : null;
//     name = json['name'];
//     university = json['university'];
//     profilePic = json['profile_pic'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     if (userId != null) {
//       data['user_id'] = userId!.toJson();
//     }
//     data['name'] = name;
//     data['university'] = university;
//     data['profile_pic'] = profilePic;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     return data;
//   }
// }
//
// class UserId {
//   String? sId;
//   String? email;
//
//   UserId({this.sId, this.email});
//
//   UserId.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     email = json['email'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['email'] = email;
//     return data;
//   }
// }
