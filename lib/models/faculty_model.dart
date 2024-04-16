class FacultyModel {
  String? sId;
  String? email;
  String? userId;
  String? name;
  String? university;
  String? profilePic;
  String? updatedAt;
  String? createdAt;
  int? iV;

  FacultyModel(
      {this.sId,
        this.email,
        this.userId,
        this.name,
        this.university,
        this.profilePic,
        this.updatedAt,
        this.createdAt,
        this.iV});

  FacultyModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['user_id'] != null) {
      if (json['user_id'] is String) {
        userId = json['user_id'];
      } else if (json['user_id'] is Map<String, dynamic>) {
        email = json['user_id']['email'];
      }
    }
    name = json['name'];
    university = json['university'];
    profilePic = json['profile_pic'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['userId'] = userId;
    data['name'] = name;
    data['university'] = university;
    data['profile_pic'] = profilePic;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}
