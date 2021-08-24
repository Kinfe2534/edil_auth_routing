class AuthData {
  String token, refreshToken, clientId;
  AuthData(this.token, this.refreshToken, {this.clientId});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    data['clientId'] = clientId;
    return data;
  }
}

class SignupData {
  String username;

  String email;

  String password;
  String name;
  String cellphone;
  SignupData(
      {this.username, this.email, this.password, this.cellphone, this.name});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['cellphone'] = cellphone;
    return data;
  }
}

class LoginData {
  String username, password;
  LoginData({
    this.username,
    this.password,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}

class UserData {
  String token;
  String type;
  int id;
  String username;
  String email;
  List<dynamic> roles;

  UserData(
      {this.token, this.type, this.id, this.username, this.email, this.roles});
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      token: json['token'] as String,
      type: json['type'] as String,
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      roles: json['roles'] as List<dynamic>,
    );
  }
}
