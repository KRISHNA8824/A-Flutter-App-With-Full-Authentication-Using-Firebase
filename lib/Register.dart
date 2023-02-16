import 'package:authentication/EmailVerify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'Login.dart';
import 'package:email_auth/email_auth.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Scaffold(
        body: MyStatefullWidget(),
      ),
    );
  }
}



class MyStatefullWidget extends StatefulWidget {
  const MyStatefullWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefullWidget> createState() => _MyStatefullWidgetState();
}

class _MyStatefullWidgetState extends State<MyStatefullWidget> {

  /*EmailAuth emailAuth = new EmailAuth(sessionName: "Sample session");
  @override
  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );

    /// Configuring the remote server
    emailAuth.config(remoteServerConfiguration);
  }*/

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  /*void sendOTP() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: emailController.value.text, otpLength: 5
    );
    if(result) {
      print("OTP sent");
    }
    else {
      print("We couldn't sent the OTP");
    }
  }

  void verifyOTP() async {
    var result = emailAuth.validateOtp(
        recipientMail: emailController.value.text,
        userOtp: passwordController.value.text);

    if(result) {
      print("OTP Verified");
    }
    else {
      print("Invalid OTP");
    }
  }*/


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: const Text(
                'Create Account',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )
          ),

          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(0, 3, 0, 15),
              child: Text(
                'Create a new account',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500]
                ),
              )
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(12, 5, 12, 5),
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              autocorrect: true,
              enableSuggestions: true,
              style: const TextStyle(height: 1.0, color: Colors.black),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Name',
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(12, 5, 12, 5),
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
            margin: const EdgeInsets.fromLTRB(12, 5, 12, 5),
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
            margin: const EdgeInsets.fromLTRB(12, 5, 12, 15),
            child: TextField(
              controller: confirmPasswordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              style: const TextStyle(height: 1.0, color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                prefixIcon: const Icon(Icons.gpp_good),
                labelText: 'Confirm Password',
              ),
            ),
          ),

          Container(
              alignment: Alignment.center,
              height: 50,
              margin: const EdgeInsets.fromLTRB(12, 5, 12, 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(13.5),
                  minimumSize: const Size.fromHeight(40),
                  primary: Colors.green,
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {

                  if(nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please fill name"),
                    ));
                  }
                  else if(emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please fill email"),
                    ));
                  }
                  else if(passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please fill age"),
                    ));
                  }
                  else if(confirmPasswordController.toString().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please fill age"),
                    ));
                  }
                  else if(passwordController.text != confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Confirm Password is not matching with Password"),
                    ));
                  }
                  else{
                    try {
                      DatabaseReference ref = FirebaseDatabase(databaseURL: "https://flutter-app-dfd57-default-rtdb.asia-southeast1.firebasedatabase.app").reference();
                      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString(),
                      ).then((value) async => {
                        await ref.child("Persons").push().set({
                          "Name": nameController.text.toString(),
                          "Email": emailController.text.toString(),
                        }).then((value) => {
                          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          //   content: Text("New account created successfully."),
                          // )),
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EmailVerify()),
                          )
                        }
                        )
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                child: const Text('Register'),

              )
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account ",
                style: TextStyle(
                    fontSize: 17
                ),
              ),

              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );},
                child: const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.green,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )

            ],
          ),

          const SizedBox(height: 15,)

        ],
      ),

    );
  }
}
