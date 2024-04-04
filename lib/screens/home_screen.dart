import 'package:expenz/services/user_details_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";
  String email = "";

  @override
  void initState() {
    //get the user details from the shared preferences
    UserService().getUserDetails().then((value) {
      //check if the user details are not null
      if (value['username'] != null && value['email'] != null) {
        //set the username and email to the state
        setState(() {
          username = value['username']!;
          email = value['email']!;
          //print the username and email
          print(username);
          print(email);
        });
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold();
  }
}
