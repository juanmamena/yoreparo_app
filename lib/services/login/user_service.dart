import 'dart:convert';

import 'package:yoreparo_app/models/models.dart';
import 'package:yoreparo_app/services/services.dart';
import 'package:http/http.dart' as http;

class UserService extends ChangeNotifier {
  //final String _baseUrl =
  //'ms-users-app.greenfield-285b2ae8.westus.azurecontainerapps.io';
  final String _baseUrl = '127.0.0.1:8085';
  final String _apiPath = '/api/v1/user';

  UserService();

  Future<UserResponse> getUser(String email) async {
    var url = Uri.http(_baseUrl, _apiPath, {'email': email});
    final response = await http.get(url);
    UserResponse userResponse =
        UserResponse(id: 0, email: 'null', isActive: false);

    if (response.statusCode == 200) {
      userResponse = UserResponse.fromRawJson(response.body);
    }
    return userResponse;
  }

  Future<UserResponse> registerUser(UserRequest userRequest) async {
    var url = Uri.http(_baseUrl, _apiPath);
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(userRequest.toJson()));
    UserResponse userResponse = UserResponse(id: 0, saved: false);
    if (response.statusCode == 201) {
      userResponse = UserResponse.fromRawJson(response.body);
    }
    return userResponse;
  }
}
