import 'package:firebasewithauthentication/common_Components/customTextFormField.dart';
import 'package:firebasewithauthentication/common_Components/custom_button.dart';
import 'package:firebasewithauthentication/core/styles.dart';
import 'package:firebasewithauthentication/features/home_page/home_page_view.dart';
import 'package:firebasewithauthentication/features/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'signup_cubit.dart';
import 'signup_state.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignupCubit(),
      child: Builder(builder: (context) =>
          BlocBuilder<SignupCubit, SignupState>(
            builder: (context, state) {
              final cubit=BlocProvider.of<SignupCubit>(context);
              return Scaffold(
body: ListView(
  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 129),
  children:  [
    const Text("Sign up ",style: TextStyle(
        fontSize: 29,color: AppStyle.primaryColor
    ),),
    GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
      },
      child: RichText(text:const TextSpan(
          children:[ TextSpan(
              text: "You  have an account?",style: TextStyle(
              color: AppStyle.greyColor,fontSize: 18
          )
          ),
            TextSpan(text: "Log in  ",style: TextStyle(
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
      // prefixIcon: Padding(
      //   padding:
      //   const EdgeInsets.only(left: 19.0, right: 7),
      //   child: SvgPicture.asset('assets/images/Vector.svg'),
      // ),
      hint: 'Password',
      hintColor: AppStyle.greyColor,
      controller: cubit.passwordController,
      keyboardType: TextInputType.text,
    ),
    CustomTextField(
      upperText: 'userName',
      radius: 5,
      isNext: true,
      hint: 'userName',
      hintColor: AppStyle.greyColor,
      controller: cubit.usernameController,
      keyboardType: TextInputType.text,
    ),
    const SizedBox(
      height: 45,
    ),
    CustomButton(title:"Sign up  " ,
        function: (){
          cubit.signUp();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));

          // Navigator.push(context,  MaterialPageRoute(builder: (context) => LoginPage()),);
        },
        bgColor: AppStyle.primaryColor,
        textColor: Colors.white),

  ],
),
              );
            },
          )),
    );
  }


}


