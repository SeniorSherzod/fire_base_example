import 'package:fire_base_example/screens/login_screen/login_screen.dart';
import 'package:fire_base_example/screens/profile_screen/profile_screen.dart';
import 'package:fire_base_example/view_models/login_view_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => LoginViewModel())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? user=FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user == null ? ProfileScreen(): LoginScreen(),
    );
  }
}