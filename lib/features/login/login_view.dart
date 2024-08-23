import 'package:firebasewithauthentication/common_Components/customTextFormField.dart';
import 'package:firebasewithauthentication/common_Components/custom_button.dart';
import 'package:firebasewithauthentication/core/styles.dart';
import 'package:firebasewithauthentication/features/home_page/home_page_view.dart';
import 'package:firebasewithauthentication/features/login/login_state.dart';
import 'package:firebasewithauthentication/features/signup/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_cubit.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          final cubit=BlocProvider.of<LoginCubit>(context);

          return Scaffold(
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 129),
              children:  [
                const Text("Log in ",style: TextStyle(
                  fontSize: 29,color: AppStyle.primaryColor
                ),),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                  },
                  child: RichText(text:const TextSpan(
                    children:[ TextSpan(
                      text: "You don't have an account?",style: TextStyle(
                      color: AppStyle.greyColor,fontSize: 18
                    )
                    ),
                      TextSpan(text: "Sign up ",style: TextStyle(
                          color: AppStyle.primaryColor,fontSize: 20)
                      )]
                  )),
                ),
                SizedBox(height: 50,),
                 CustomTextField(
                  upperText: 'Email Address',
                  radius: 5,
                  isNext: true,

                  hint: 'Email Address',
                  hintColor: AppStyle.greyColor,
                 controller: cubit.emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                 CustomTextField(
                  upperText: 'Password',
                  radius: 5,
                  isNext: true,
                  hint: 'Password',
                  hintColor: AppStyle.greyColor,
                   controller: cubit.passwordController,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 45,
                ),
                CustomButton(title:"Log in " ,
                    function: (){
                  cubit.signIn();
                  Navigator.push(context,  MaterialPageRoute(builder: (context) => HomePage()),);
                    },
                    bgColor: AppStyle.primaryColor,
                    textColor: Colors.white)
              ],
            ),
          );
        },
      ),
    );
  }


}


