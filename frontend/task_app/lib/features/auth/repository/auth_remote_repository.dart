import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_app/core/constants/constants.dart';
import 'package:task_app/core/services/sp_services.dart';
import 'package:task_app/features/auth/repository/auth_local_repository.dart';
import 'package:task_app/models/user.dart';

class AuthRemoteRepository {
  final spService = SpService();
  final authLocalRepository = AuthLocalRepository();

  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      final res = await http.post(
          Uri.parse('${Constants.backendUri}/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}));

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['msg'];
      }

      return UserModel.fromMap(jsonDecode(res.body));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserModel> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final res = await http.post(
          Uri.parse('${Constants.backendUri}/auth/signup'),
          headers: {'Content-Type': 'application/json'},
          body:
              jsonEncode({'name': name, 'email': email, 'password': password}));

      if (res.statusCode != 201) {
        throw jsonDecode(res.body)['msg'];
      }

      return UserModel.fromMap(jsonDecode(res.body));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserModel?> getUser() async {
    try {
      final token = await spService.getToken();

      //Token was not found
      if (token == null) {
        return null;
      }

      //Checking if the token is valid or not
      final userResponse = await http.post(
          Uri.parse('${Constants.backendUri}/auth/validToken'),
          headers: {'Content-Type': 'application/json', 'x-auth-token': token});

      //If token is not valid then return null
      if (userResponse.statusCode != 200 ||
          jsonDecode(userResponse.body) == false) {
        return null;
      }

      //Now the token is valid and retrive users

      final user = await http.get(Uri.parse('${Constants.backendUri}/auth'),
          headers: {'Content-Type': 'application/json', 'x-auth-token': token});

      if (user.statusCode != 200) {
        throw jsonDecode(user.body)['msg'];
      }

      return UserModel.fromJson(user.body);
    } catch (e) {
      final user = await authLocalRepository.getUser();
      if (user != null) return user;
      return null;
    }
  }
}
