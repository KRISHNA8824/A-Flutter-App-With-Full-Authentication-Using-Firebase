import 'package:authentication/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Login.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  @override
  void initState() {
    if(FirebaseAuth.instance.currentUser != null) {
      Future.delayed(Duration.zero,(){
        //your code goes here
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HomePage()
        )).then((value) => (){
          Navigator.of(context).pop();
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext  context) {
    return Login();
  }
}
