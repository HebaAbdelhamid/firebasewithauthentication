import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasewithauthentication/core/styles.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  final String chatWithUserId;
  final String chatWithUsername;

  ChatScreen({required this.chatWithUserId, required this.chatWithUsername});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  void sendMessage() {
    if (messageController.text.isEmpty) return;

    FirebaseFirestore.instance.collection('chats').add({
      'senderId': FirebaseAuth.instance.currentUser!.uid,
      'receiverId': widget.chatWithUserId,
      'message': messageController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.chatWithUsername}',style: TextStyle(color: Colors.white),),
        backgroundColor: AppStyle.primaryColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .orderBy('timestamp', descending: false) // Orders by timestamp
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No messages yet.'));
                }

                final messages = snapshot.data!.docs.where((doc) {
                  return (doc['senderId'] == FirebaseAuth.instance.currentUser!.uid &&
                      doc['receiverId'] == widget.chatWithUserId) ||
                      (doc['senderId'] == widget.chatWithUserId &&
                          doc['receiverId'] == FirebaseAuth.instance.currentUser!.uid);
                }).toList();

                if (messages.isEmpty) {
                  return Center(child: Text('No messages available.'));
                }

                return ListView.builder(
                  reverse: false,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message['senderId'] == FirebaseAuth.instance.currentUser!.uid;

                    return ListTile(
                      title: Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue[200] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(message['message']),
                        ),
                      ),
                      subtitle: Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Text(isMe ? 'You' : widget.chatWithUsername),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      labelText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue[200]),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



