import 'package:coffee_house/models/user_account.dart';
import 'package:coffee_house/service/user_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void GetUserData() async {
    final UserAccount? currentUser = await UserService.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("data"),
        ),
      ),
    );
  }
}
