import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'RegisterScreen2.dart';
import 'Login.dart';

class Screen extends StatelessWidget {
  const Screen({Key? key}) : super(key: key);

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

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              // decoration: BoxDecoration(
              //     border: Border.all(color: Colors.blueAccent)
              // ),
              child: const Text(
                'Create Account',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              )
          ),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(10, 3, 10, 15),
              // decoration: BoxDecoration(
              //     border: Border.all(color: Colors.blueAccent)
              // ),
              child: Text(
                'Create a new account',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[500]
                ),
              )
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: UnderlineInputBorder(),
                labelText: 'Name',
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                border: UnderlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                border: UnderlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              controller: confirmPasswordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.gpp_good),
                labelText: 'Confirm Password',
              ),
            ),
          ),


          Container(
              alignment: Alignment.center,
              height: 50,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 8),
              child: ElevatedButton(
                child: const Text('Register'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                    primary: Colors.green,
                    textStyle: const TextStyle(
                        fontSize: 20
                    )),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );

                  if(nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please fill name"),
                    ));
                  }
                  else if(emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please fill email"),
                    ));
                  }
                  else if(passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please fill age"),
                    ));
                  }
                  else if(confirmPasswordController.toString().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please fill age"),
                    ));
                  }
                  else if(passwordController.text != confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Confirm Password is not matching with Password"),
                    ));
                  }
                  else{

                    /*try {
                      DatabaseReference ref = FirebaseDatabase(databaseURL: "https://flutter-app-dfd57-default-rtdb.asia-southeast1.firebasedatabase.app").reference();
                      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString(),
                      ).then((value) async => {
                        await ref.child("Persons").push().set({
                        "Name": nameController.text.toString(),
                        "Email": emailController.text.toString(),
                        "Password": passwordController.text.toString(),
                      }).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("New account created successfully."),
                      )))
                      });

                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }*/

                  }

                },

              )
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account ",
                style: TextStyle(
                    fontSize: 16
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
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )

            ],
          ),


        ],
      ),
    );
  }
}



