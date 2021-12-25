import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

   AnimationController ? controller ;

   Animation ? animation;

  @override
  void initState() {
    super.initState();
    controller=AnimationController(
        duration: const Duration(seconds: 3),
        vsync: this
    );
    controller!.forward();

    animation=ColorTween(begin: Colors.white,end: Colors.lightBlue).animate(controller!);

    controller!.addListener(() {
      setState(() {

      });
      print(animation!.value);
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.isDismissed;
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: animation!.value,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(

                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                  'Flash Chat',
                  speed:const  Duration(milliseconds: 150),
                  textStyle: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  )
    )
    ]

            ),

      ),
          const  SizedBox(height: 30,),
            SizedBox(
              height: 43,
              width: 200,
         child: ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, 'Login_Screen');
              }, child:const Text("Login"))),
           const SizedBox(height: 10,),

            SizedBox(
              height: 43,
              width: 200,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, 'Register_Screen');
                  }, child:const Text("Register")),
            )
          ],
        ),
    )
    );
  }
}
