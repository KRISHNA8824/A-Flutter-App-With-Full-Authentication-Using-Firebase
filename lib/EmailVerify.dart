import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({Key? key}) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    user = auth.currentUser!;
    user.sendEmailVerification();
    
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("An email has sent to ${user.email} please verify"),),
    );
  }

  Future<void> checkEmailVerified() async {
     user = auth.currentUser!;
     await user.reload();

     if(user.emailVerified) {
       timer.cancel();
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
         content: Text("New account created successfully."),
       ));
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => HomePage()),
       );
     }
  }
}
