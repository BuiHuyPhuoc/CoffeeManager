// ignore_for_file: unused_import

import 'package:coffee_house/firebase_options.dart';
import 'package:coffee_house/screens/auth_redirect.dart';
import 'package:coffee_house/screens/login_screen.dart';
import 'package:coffee_house/screens/order_detail_screen.dart';
import 'package:coffee_house/screens/order_screen.dart';
import 'package:coffee_house/service/signalr_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final container = ProviderContainer();
  await container.read(signalRProvider).initSignalR();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthRedirect(
      child: MaterialApp(
        home: OrderScreen(),
      ),
    );
  }
}