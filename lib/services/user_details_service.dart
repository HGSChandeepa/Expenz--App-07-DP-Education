import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  //init the shared preferences
  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  //Store the userName and password using shared preferences
  Future<void> storeUserDetails(String username, String email, String password,
      String confirmPassword, BuildContext context) async {
    //check if the password and confirm password are the same
    if (password != confirmPassword) {
      //show a snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password and Confirm Password do not match"),
        ),
      );
    }
    //Store the username and email in shared preferences
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setString('email', email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User Details stored successfully"),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  //Get the username and email from shared preferences
  Future<Map<String, String>> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? email = prefs.getString('email');
    return {'username': username!, 'email': email!};
  }
}
