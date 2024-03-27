import 'package:chat_app/SignUpORSignIn/sign_in.dart';
import 'package:chat_app/SignUpORSignIn/sign_up.dart';
import 'package:flutter/cupertino.dart';

class TogglePages extends StatefulWidget {
  const TogglePages({super.key});

  @override
  State<TogglePages> createState() => _TogglePagesState();
}

class _TogglePagesState extends State<TogglePages> {
  bool signUpPage = false;

  void ChangePage(){
    setState(() {
      signUpPage = !signUpPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(signUpPage){
      return SignUp(onTap: ChangePage,);
    }else{
      return SignIn(onTap: ChangePage,);
    }
  }
}
