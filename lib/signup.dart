import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasewithauthentication/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(4),borderSide:BorderSide(color: Colors.green) )),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(4),borderSide:BorderSide(color: Colors.green))),
              obscureText: true,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'UserName',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(4),borderSide:BorderSide(color: Colors.green))),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                _signUp();
              },
              child: Text('Sign Up'),
            ),
            TextButton(
              style: ButtonStyle( backgroundColor: MaterialStateProperty.all<Color>(Colors.green),),

                onPressed: (){

              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
            }, child: Text('login',style: TextStyle(color: Colors.white),))
          ],
        ),
      ),
    );
  }

  void _signUp() async {
    try {
     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        "email":emailController.text,
        "password":passwordController.text,
        "username":usernameController.text
      });

      print("done");
    } catch (e) {
      print('Error during sign up: $e');
    }
  }//        android:name="${applicationName}"

}
