class CourseModel {
  String? sId;
  String? userId;
  String? name;
  String? description;
  String? fileUrl;
  String? createdAt;
  String? updatedAt;

  CourseModel(
      {this.sId,
        this.userId,
        this.name,
        this.description,
        this.fileUrl,
        this.createdAt,
        this.updatedAt});

  CourseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    name = json['name'];
    description = json['description'];
    fileUrl = json['file_url'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user_id'] = userId;
    data['name'] = name;
    data['description'] = description;
    data['file_url'] = fileUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
