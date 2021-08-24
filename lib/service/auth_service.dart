import 'dart:convert';
import 'package:edil/model/auth_model.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final Uri signupUrl = Uri.parse("http://localhost:8080/api/auth/signup");
  final Uri loginUrl = Uri.parse("http://localhost:8080/api/auth/signin");
  static final SESSION = FlutterSession();

  Future<dynamic> register(SignupData signupData) async {
    try {
      var body = jsonEncode(signupData.toJson());
      http.Response res = await http.post(signupUrl,
          headers: {"Content-Type": "application/json"}, body: body);
      return res;
    } catch (e) {
      print(e.toString());
    } finally {
      print("@Register ");
      print(jsonEncode(signupData));
      //done u can do sth here
    }
  }

  Future<dynamic> login(LoginData loginData) async {
    try {
      var body = jsonEncode(loginData.toJson());
      http.Response res = await http.post(loginUrl,
          headers: {"Content-Type": "application/json"}, body: body);
      return res;
    } catch (e) {
      print(e.toString());
    } finally {
      print("@Login ");
      print(jsonEncode(loginData));
      //done u can do sth here
    }
  }

  static setToken(String token, String refreshToken) async {
    AuthData data = AuthData(token, refreshToken);
    return SESSION.set('tokens', data);
  }

  static getToken() async {
    return await SESSION.get('tokens');
  }
}
