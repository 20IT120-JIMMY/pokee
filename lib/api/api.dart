import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokee/models/addusermodel.dart';
import 'package:pokee/models/getusermodel.dart';

class AddUser {
  AddUser();
  Future<AddUserModel> AddUserData(
      uid, firstname, lastname, username, phone_no) async {
    var url = "http://user-service.pokee.app/v1/user";
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          "content-type": "application/json",
        },
        body: json.encode({
          "id": uid,
          "first_name": firstname,
          "last_name": lastname,
          "user_name": username,
          "phone_number": phone_no
        }));
    var data = json.decode(response.body);
    print("Add User : " + response.body);
    return AddUserModel.fromJson(data);
  }
}

class GetUser {
  GetUser();
  Future<GetUserModel> UserData(uid) async {
    var url = "http://user-service.pokee.app/v1/user/${uid}";
    http.Response response = await http.get(
      Uri.parse(url),
    );
    var data = json.decode(response.body);
    print("User : " + response.body);
    return GetUserModel.fromJson(data);
  }
}
