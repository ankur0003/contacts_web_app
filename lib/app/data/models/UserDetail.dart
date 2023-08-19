class UserDetail {
  String? username;
  String? email;
  String? id;

  UserDetail({this.username, this.email, this.id});

  UserDetail.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['id'] = id;
    return data;
  }
}
