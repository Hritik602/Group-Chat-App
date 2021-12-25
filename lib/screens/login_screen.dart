

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth=FirebaseAuth.instance;
  String ? registerEmail;
  String ? registerPassword;
  bool showSpin=false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpin,
        child: Container(
          padding:const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                textAlign: TextAlign.center,
                decoration:const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:  BorderRadius.all(Radius.circular(20))
                    ),
                    constraints: BoxConstraints(
                        maxWidth: 340
                    ),
                    hintText: "Enter Email"
                ),
                onChanged: (value){
                  registerEmail=value;
                },
              ),
              const SizedBox(height: 20,),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,

                decoration:const InputDecoration(
                    fillColor: Colors.black,
                    focusColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius:  BorderRadius.all(Radius.circular(20)),

                    ),
                    constraints: BoxConstraints(
                        maxWidth: 340
                    ),
                    hintText: "Enter Password"
                ),
                onChanged: (value){
                  registerPassword=value;
                },
              ),
              const SizedBox(height: 20,),
              Container(
                height: 43,
                width: 200,
                child: ElevatedButton(
                    onPressed: ()async {
                      // print(userEmail);
                      // print(userPassword);
                      setState(() {
                        showSpin=true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: registerEmail!, password: registerPassword!);
                        if(user!=null) {
                          Navigator.pushNamed(context, 'Chat_Screen');
                        }
                       setState(() {
                         showSpin=false;
                       });
                      }
                      catch(e){
                        print(e);
                      }
                    },
                    child:const Text("Login")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
