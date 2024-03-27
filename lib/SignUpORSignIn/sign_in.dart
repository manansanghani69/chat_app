import 'package:chat_app/SignUpORSignIn/components/button.dart';
import 'package:chat_app/SignUpORSignIn/components/mytextfield.dart';
import 'package:chat_app/models/constants.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, required this.onTap});
  final void Function()? onTap;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signIn() async {
    final authState = AuthService();

    try {
      await authState.signInWithEmailandPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    print("object");
  }

  bool fieldsFilled = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        if (_emailController.text != "" && _passwordController.text.length >= 6) {
          fieldsFilled = true;
        } else {
          fieldsFilled = false;
        }
        print("printed$fieldsFilled");
      }); // setState every time text changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Icon(
                  Icons.message,
                  size: 150,
                  color: kSecondary,
                ),
                //title
                Text(
                  "CHIT CHAT",
                  style: GoogleFonts.bebasNeue(
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                      letterSpacing: 2,
                      color: kText),
                ),
                const SizedBox(
                  height: 40,
                ),
                //email
                MyTextField(
                  hint: "email",
                  controller: _emailController,
                  obscureText: false,
                ),
                const SizedBox(
                  height: 25,
                ),
                //password
                MyTextField(
                  hint: "password",
                  controller: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                //sign in button
                MyButton(
                  btn: 'Sign In',
                  fun: signIn,
                  textFieldsFilled: fieldsFilled,
                ),
                const SizedBox(
                  height: 25,
                ),
                //msg + register btn
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "not a member?  ",
                      style: GoogleFonts.bebasNeue(
                          color: kPrimary,
                          fontSize: 20,
                          wordSpacing: 1,
                          letterSpacing: 1),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register Now!",
                        style: GoogleFonts.bebasNeue(
                            fontSize: 20,
                            wordSpacing: 1,
                            letterSpacing: 1,
                            color: kSecondary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
