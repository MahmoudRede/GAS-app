import 'package:flutter/material.dart';
import 'package:gas/style/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Function onTap;
  const ButtonWidget({Key? key,required this.buttonText,required this.buttonColor,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7)
      ),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height*.055
      ),
      color: ColorManager.buttonColor,
      onPressed: (){
        onTap();
      },
      child: Text(buttonText,style: GoogleFonts.almarai(
          fontWeight: FontWeight.w400,
          fontSize: MediaQuery.of(context).size.height*.018,
          color: buttonColor
      ),
      ),
    );
  }
}
