import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  Future<bool> checkLogIn(int number) async {
    final response = await http.post(
      Uri.parse(
          "https://asia-south1-hilifedb.cloudfunctions.net/checkCreateBeatActivationCode"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "code": number.toString(),
        },
      ),
    );
    if (response.statusCode == 200) {
      if (response.body == "True") {
        print("should enter");
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}