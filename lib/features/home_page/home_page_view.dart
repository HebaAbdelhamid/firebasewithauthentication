import 'package:firebasewithauthentication/core/styles.dart';
import 'package:firebasewithauthentication/features/chat_page/chat_page_view.dart';
import 'package:firebasewithauthentication/features/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconic/iconic.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyle.primaryColor,
        title: Text('Home Page',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(icon:Icon(Iconic.sign_out_alt),onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
          },)
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No emails found.'));
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(chatWithUserId: user.id, chatWithUsername: user["username"],)));
                },
                child: ListTile(
                  title: Text(user['email']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}




