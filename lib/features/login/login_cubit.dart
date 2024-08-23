import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

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
