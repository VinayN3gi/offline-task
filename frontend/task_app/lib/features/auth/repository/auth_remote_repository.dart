import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_app/core/constants/constants.dart';
import 'package:task_app/models/user.dart';

class AuthRemoteRepository {
  Future<void> login() async {}

  Future<UserModel> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final res = await http.post(
          Uri.parse('${Constants.backendUri}/auth/signup'),
          headers: {'Content-Type': 'application/json'});

      if (res.statusCode != 201) {
        throw jsonDecode(res.body)['msg'];
      }

      return UserModel.fromMap(jsonDecode(res.body));
    } catch (e) {
      throw e.toString();
    }
  }
}
