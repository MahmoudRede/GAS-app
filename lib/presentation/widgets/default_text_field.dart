
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/style/app_color.dart';
import 'package:gas/utils/local/cash_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatefulWidget {
  final String hintText;
  final String labelText;
  IconData? prefixIcon;
  IconData? suffixIcon;
  bool isPass ;
  bool isLocation ;
  int? lines;
  Color ? hintColor;
  TextInputType textInputType;
  TextEditingController controller = TextEditingController();

   DefaultTextField({
    required this.hintText,
    required this.controller,
     this.hintColor=Colors.black,
    this.isPass = false,
    this.isLocation = false,
    required this.textInputType,
     this.labelText = "",
      this.prefixIcon,
     this.suffixIcon,
     this.lines = 1,
    Key? key}) : super(key: key);

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    return widget.isPass == false?Container(
      padding:  const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        textDirection: widget.isLocation==false? CashHelper.getData(key: CashHelper.languageKey).toString() == 'en'? TextDirection.ltr:TextDirection.rtl:TextDirection.ltr,
        style: GoogleFonts.almarai(
          fontSize: MediaQuery.of(context).size.height*.022,
          fontWeight: FontWeight.w500,
          color: ColorManager.textColor,
        ),
        decoration: InputDecoration(

            hintText: widget.hintText,
            hintStyle: GoogleFonts.almarai(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey[500]
            ),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                 borderSide: const BorderSide(
                   color: Colors.white
                 )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3)
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(
                    color: Colors.red,

                )
            ),
            errorStyle: GoogleFonts.almarai(
              fontSize: 13.0,
              color: ColorManager.red,
            ),
            fillColor: Colors.white,
            filled: true,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: ColorManager.primaryColor,
          ),
        ),
        keyboardType: widget.textInputType,
        controller: widget.controller,
        validator: (value){
          if(value!.isEmpty){
            return AppLocalizations.of(context)!.translate('validatedText').toString();
          }
          return null;
        },
      ),
    ):Container(
      padding:  const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
      ),
      child: TextFormField(
        style: GoogleFonts.almarai(
            fontSize: 15.0,
            color: ColorManager.textColor,
          ),
        decoration: InputDecoration(
          
          hintText: widget.hintText,
            hintStyle: GoogleFonts.almarai(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey[500]
            ),
          border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(
                    color: Colors.white
                )
            ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(
                  color: Colors.white
              )
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(
                color: Colors.red
              )
          ),
          errorStyle: GoogleFonts.almarai(
            fontSize: 13.0,
            color: ColorManager.red,
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(
              widget.prefixIcon,
              color: ColorManager.primaryColor,
          ),
          suffixIcon: widget.isPass == true? IconButton(
              onPressed: (){
                setState(() {
                  isChecked =! isChecked;
                });
              },
              icon: isChecked == true ?  Icon(
                Icons.visibility_off,
                color: ColorManager.primaryColor,
              ) :  Icon(
                Icons.visibility,
                color: ColorManager.primaryColor,
              ) ,
          ) : IconButton(
            onPressed: (){},
            icon: widget.suffixIcon != null ? Icon(
              widget.suffixIcon,
              color: ColorManager.primaryColor,
            ) : const SizedBox(
              height: 1,
              width: 1,
            ),
          )
        ),
        keyboardType: widget.textInputType,
        controller: widget.controller,
        obscureText: isChecked,
        validator: (value){
          if(value!.isEmpty){
            return AppLocalizations.of(context)!.translate('validatedText').toString();
          }
          return null;
        },
      ),
    );
  }
}
