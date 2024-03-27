import 'package:chat_app/SignUpORSignIn/components/button.dart';
import 'package:chat_app/SignUpORSignIn/components/mytextfield.dart';
import 'package:chat_app/models/constants.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, required this.onTap});
  final void Function()? onTap;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("passwords does not match")));
    } else {
      final AuthState = AuthService();

      try {
        AuthState.createUserWithEmailAndPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  bool fieldsFilled = false;

  @override
  void initState() {
    super.initState();
    _confirmPasswordController.addListener(() {
      setState(() {
        if (_emailController.text != "" &&
            _passwordController.text.length >= 6 &&
            _passwordController.text == _confirmPasswordController.text) {
          fieldsFilled = true;
        } else {
          fieldsFilled = false;
        }
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
                  height: 20,
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
                //confirm password
                MyTextField(
                  hint: "confirm password",
                  controller: _confirmPasswordController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                //sign up button
                MyButton(
                  btn: 'Sign Up',
                  fun: signUp,
                  textFieldsFilled: fieldsFilled,
                ),
                const SizedBox(
                  height: 25,
                ),
                //msg + sign in btn
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "already a member?  ",
                      style: GoogleFonts.bebasNeue(
                          color: kPrimary,
                          fontSize: 20,
                          wordSpacing: 1,
                          letterSpacing: 1),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "login Now!",
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
