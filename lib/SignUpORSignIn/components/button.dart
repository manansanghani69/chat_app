import 'package:chat_app/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatefulWidget {
  MyButton({super.key, required this.btn, this.fun, required this.textFieldsFilled,});
  final Function()? fun;
  final String btn;
  bool textFieldsFilled;

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  var btnColor;

  Future<void> ChangeBtnColor() async {
    setState(() {
      if(widget.textFieldsFilled){
        btnColor = kSecondary;
      }else{
        btnColor = kPrimary;
      }
    });
  }
  @override
  void initState() {
    super.initState();
    ChangeBtnColor();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.fun,
      child: Container(
        width: MediaQuery.of(context).size.width - 2 * 20,
        height: 65,
        decoration: BoxDecoration(
          color: (widget.textFieldsFilled)? kSecondary : kPrimary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            widget.btn,
            style: GoogleFonts.bebasNeue(
                color: kText, fontSize: 30, letterSpacing: 1),
          ),
        ),
      ),
    );
  }
}
