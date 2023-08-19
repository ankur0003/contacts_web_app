class MyContacts {
  String? sId;
  String? userId;
  String? name;
  String? email;
  String? phone;
  String? createdAt;
  String? updatedAt;

  MyContacts(
      {this.sId,
        this.userId,
        this.name,
        this.email,
        this.phone,
        this.createdAt,
        this.updatedAt});

  MyContacts.fromJson(Map<String,dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
