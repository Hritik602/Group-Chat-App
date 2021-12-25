
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _chatMessage=FirebaseFirestore.instance;

User ? user;
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  final _auth =FirebaseAuth.instance;


  String ? chatMessages;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData(){
    try {
      final loggedIn = _auth.currentUser;
      if (loggedIn != null) {
        user = loggedIn;
      }
    }
    catch(e){
      print (e);
    }
  }

  void messageStream()async{
    await for(var snapshot in _chatMessage.collection('messages').snapshots()){
      for(var messages in snapshot.docs){
        print(messages.data());
      }
    }
  }

  final textController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          actions:[

           IconButton(
          onPressed: (){
            messageStream();
            // _auth.signOut();
            // Navigator.pop(context);
          },
          icon:const Icon(Icons.logout),
        ),
        ],
        centerTitle: true,
        title: Text('Chat'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

           const MessageStream(),
            Container(
              padding:const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration:const InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none
                        ),
                        hintText: "Type your messages here..."
                      ),
                      onChanged: (value){
                        chatMessages=value;
                      },
                    ),
                  ),
                  TextButton(
                      onPressed: (){

                        _chatMessage.collection('messages').add({
                          'sender':user!.email,
                          'text':chatMessages,

                        });
                        textController.clear();
                      },
                      child:const Text("Send"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _chatMessage.collection('messages').snapshots(),
        builder:(context,snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          final message=snapshot.data!.docs.reversed;
          List<MessageBubble> messagesWidgets=[];
          for(var messageChat in message ){
            final messageText=messageChat['text'];
            final messageSender =messageChat['sender'];
            final currentUser = user!.email;
            final messageWid=MessageBubble(text: messageText,sender: messageSender,isMe:currentUser==messageSender);
            messagesWidgets.add(messageWid);
          }
          return Expanded(
            child: ListView(
              reverse: false,
              children: messagesWidgets,
            ),
          );
        }
    );
  }
}


class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key,this.text,this.sender,this.isMe}) : super(key: key);

  final String ?text;
  final String ?sender;
  final bool ? isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:isMe!? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(sender!, style:const TextStyle(fontSize: 16,wordSpacing: 2.0),),
          Material(
            elevation: 5.0,
            borderRadius:isMe!? const BorderRadius.only(
                topLeft: Radius.circular(20)  ,
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20) ):const BorderRadius.only(
                topRight: Radius.circular(10)  ,
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20) ),

            color:isMe! ? Colors.blueAccent :Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(text!,

              style: TextStyle(fontSize: 20),
              ),
            ) ,
          ),
        ],
      ),
    );
  }
}
