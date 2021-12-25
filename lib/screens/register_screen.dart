


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}




class _RegisterScreenState extends State<RegisterScreen> {

  final _authh=FirebaseAuth.instance;


  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  String ?userEmail;
  String ?userPassword;
  bool showSpin=false;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title:const Text('Register'),
      // ),
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
                  userEmail=value;
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
                 userPassword=value;
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
                        final user = await _authh.createUserWithEmailAndPassword(
                            email: userEmail!, password: userPassword!);
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
                    child:const Text("Register")),
              )
            ],
          ),
      ),
       ),
    );
  }
}
