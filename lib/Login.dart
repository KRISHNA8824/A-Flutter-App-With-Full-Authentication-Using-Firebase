import 'dart:async';

import 'package:authentication/HomePage.dart';
import 'package:authentication/Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children:  <Widget>[
            Container(
                alignment: Alignment.center,
                child: Icon(Icons.person_outline_outlined, color: Colors.grey[300], size: 90,)
            ),

            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: const Text("Wellcome Back", style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),)
            ),

            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Text("Sign in to continue", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[400]
                ),)
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: true,
                enableSuggestions: true,
                style: const TextStyle(height: 1.0, color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'Email',
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                style: const TextStyle(height: 1.0, color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'Password',
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green
                        ),
                      )
                  )
                ],
              ),
            ),


            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    minimumSize: const Size.fromHeight(40),
                    primary: Colors.green,
                    textStyle: const TextStyle(
                        fontSize: 20
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {

                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text
                      ).then((value) => {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Login successfully."),
                      )),
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        )
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("No user found for that email."),
                        ));
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Wrong password provided for that user."),
                        ));
                      }
                    }
                  },
                  child: const Text('Login'),

                )
            ),


            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: const Text(
                "OR",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                ),
              ),
            ),

            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(12, 10, 12, 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(11),
                    minimumSize: const Size.fromHeight(40),
                    primary: Colors.black,
                    textStyle: const TextStyle(
                        fontSize: 20
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset("assets/google_logo.svg", height: 28.0,),
                        // Image(image: AssetImage('assets/google_logo.png'), height: 35.0),
                        const SizedBox(width: 5,),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  onPressed: () async {

                    signInWithGoogle(context).whenComplete(() {
                      // Perform some action here after successful sign in
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Login successfully."),
                      ));
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    });
                  },

                )
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account ",
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),

                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );},
                  child: const Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 15,)

          ],
        ),
          ),
    );
  }

  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    // First disconnect previous selected account
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    var result =  await firebaseAuth.signInWithCredential(credential);

    final user = result.user;
    String? Name = user?.displayName.toString();
    String? Email = user?.email.toString();


    bool check = true;

    DatabaseReference ref = FirebaseDatabase(databaseURL: "https://flutter-app-dfd57-default-rtdb.asia-southeast1.firebasedatabase.app").reference();
    await ref.child("Persons").once().then((dataSnapshot) {
      dataSnapshot.snapshot.children.forEach((element) {
        String id = ((element.value as Map) ["Email"]).toString();
        if(id==(user?.email.toString())) {
          check = false;
        }
      });
    });

    // bool f = true;
    // final TextEditingController _nameController = TextEditingController();
    if(check) {

      /*showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Fill the details'),
              *//*content: SingleChildScrollView(
                child: Text(
                        "name : ${Name!}\nEmail : ${Email!}"
                ),
              ),*//*

              content: Container(
                height: 150,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Name : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        SizedBox(width: 5,),

                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                        ),


                      ],
                    ),

                    SizedBox(height: 20),

                    Text(
                      "Email : ${Email!}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    f = false;
                  },
                ),
              ],

            );
          }
      );
      while(f) {
        await Future.delayed(const Duration(milliseconds: 250));
      }
*/

      await ref.child("Persons").push().set({
        "Name": user?.displayName.toString(),
        "Email": user?.email.toString(),
      });
    }

    return result;

  }

}

