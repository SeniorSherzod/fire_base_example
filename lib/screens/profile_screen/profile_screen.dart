import 'package:fire_base_example/utils/styles/styles.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Profile Screen"),
        automaticallyImplyLeading: false,
      ),
     body: Column(
       children: [
         Center(child: Text("YOU ARE WELCOME",style: AppTextStyle.rubikMedium.copyWith(fontSize: 30),),)
       ],
     ),
    );
  }
}
