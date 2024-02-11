
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasewithauthentication/signup.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4),borderSide:BorderSide(color: Colors.green))),

            ),
            SizedBox(height: 20),

            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(4),borderSide:BorderSide(color: Colors.green))),

              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),

              onPressed: () {
                signIn();
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            TextButton(
style: ButtonStyle( backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),

        onPressed: () {
                Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('Don\'t have an account? Sign Up',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  void signIn()async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      print('User signed in: ${userCredential.user!.uid}');
    } catch (e) {
      print('Error during sign in: $e');
    }
  }
}
