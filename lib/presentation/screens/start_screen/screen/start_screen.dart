import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gas/business_logic/app_cubit/app_cubit.dart';
import 'package:gas/business_logic/app_cubit/app_states.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/business_logic/localization_cubit/localization_cubit.dart';
import 'package:gas/presentation/screens/driver_login/screen/driver_login.dart';
import 'package:gas/presentation/screens/driver_screen/screen/driver_screen.dart';
import 'package:gas/presentation/screens/home_screen/screen/home_screen.dart';
import 'package:gas/presentation/widgets/toast.dart';
import 'package:gas/style/app_color.dart';
import 'package:gas/utils/local/cash_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        builder: (context,state){
          return Scaffold(
            backgroundColor: ColorManager.primaryColor,
            appBar: AppBar(
              actions: [

                GestureDetector(
                  onTap: (){
                    if(CashHelper.getData(key: CashHelper.languageKey).toString() == 'en'){
                      LocalizationCubit.get(context).changeLanguage(code: 'ar');
                    }
                    else{
                      LocalizationCubit.get(context).changeLanguage(code: 'en');
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                        Text(
                            AppLocalizations.of(context)!.translate('language').toString(),
                            style: GoogleFonts.almarai(
                              fontSize: MediaQuery.of(context).size.height*.02,
                              color: ColorManager.textColor,
                              fontWeight: FontWeight.w700
                            ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*.005,),

                      CashHelper.getData(key: CashHelper.languageKey).toString() == 'en'?
                      Container(
                        width: MediaQuery.of(context).size.height*.06,
                        height: MediaQuery.of(context).size.height*.0035,
                        color: Colors.black,
                      ):Container(
                        width: MediaQuery.of(context).size.height*.03,
                        height: MediaQuery.of(context).size.height*.0035,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.height*.025,),
              ],
              elevation: 0.0,

            ),
            body: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*.04,),

                Image(
                  image: const AssetImage('assets/images/small_gas.png'),
                  height: MediaQuery.of(context).size.height*.15,
                  width: MediaQuery.of(context).size.height*.15,
                ),

                SizedBox(height: MediaQuery.of(context).size.height*.02,),

                Text(AppLocalizations.of(context)!.translate('appName').toString(),style: GoogleFonts.almarai(
                    fontWeight: FontWeight.w700,
                    fontSize: MediaQuery.of(context).size.height*.035,
                    color: ColorManager.black),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: MediaQuery.of(context).size.height*.02,),

                Text(AppLocalizations.of(context)!.translate('welcomeMessage').toString(),style: GoogleFonts.almarai(
                    fontWeight: FontWeight.w700,
                    fontSize: MediaQuery.of(context).size.height*.038,
                    color: ColorManager.black),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Container(
                  height: MediaQuery.of(context).size.height*.45,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    children: [

                      SizedBox(height: MediaQuery.of(context).size.height*.04,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: AppCubit.get(context).isCheckBoxTrue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              side: MaterialStateBorderSide.resolveWith(
                                    (states) =>  BorderSide(
                                    width: 1.0, color: ColorManager.white
                                ),),
                              onChanged: (bool? value) {
                                AppCubit.get(context).changeCheckBox(value: value!);
                              }),
                          Text.rich(
                            TextSpan(
                                text: AppLocalizations.of(context)!.translate('privacyMessage').toString(),
                                style: GoogleFonts.almarai(
                                    fontSize: MediaQuery.of(context).size.height*.021,
                                    color:ColorManager.white,
                                    fontWeight: FontWeight.w600
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.translate('privacyLink').toString(),
                                    style: GoogleFonts.almarai(
                                        fontSize: MediaQuery.of(context).size.height*.021,
                                        color:ColorManager.buttonColor,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        AppCubit.get(context).toPrivacy();
                                      },
                                  ),
                                ]),
                          ),
                        ],
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*.02,),

                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*.025),
                        child: Text(AppLocalizations.of(context)!.translate('warningMessage').toString(),style: GoogleFonts.almarai(
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.height*.022,
                            color: ColorManager.grey
                        ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*.055,),

                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: CashHelper.getData(key: CashHelper.languageKey).toString() == 'en'?MediaQuery.of(context).size.height*.18:MediaQuery.of(context).size.height*.19,
                          vertical: MediaQuery.of(context).size.height*.018,
                        ),
                        color: ColorManager.buttonColor,
                        onPressed: (){

                          if(AppCubit.get(context).isCheckBoxTrue==true){
                            Navigator.push(context, MaterialPageRoute(builder: (_){
                              return  HomeScreen();
                            }));
                          }
                          else{
                            customToast(title:AppLocalizations.of(context)!.translate('privacyToast').toString(), color: Colors.red);
                          }

                        },
                        child: Text(AppLocalizations.of(context)!.translate('customer').toString(),style: GoogleFonts.almarai(
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.height*.022,
                            color: ColorManager.white
                        ),),
                      ),

                      SizedBox(height:MediaQuery.of(context).size.height*.02,),

                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.height*.2,
                          vertical: MediaQuery.of(context).size.height*.018,
                        ),
                        color: ColorManager.buttonColor,
                        onPressed: (){

                          if(AppCubit.get(context).isCheckBoxTrue==true){
                            Navigator.push(context, MaterialPageRoute(builder: (_){
                              return const DriverLoginScreen();
                            }));
                          }
                          else{
                            customToast(title:AppLocalizations.of(context)!.translate('privacyToast').toString(), color: Colors.red);
                          }

                        },
                        child: Text(AppLocalizations.of(context)!.translate('driver').toString(),style: GoogleFonts.almarai(
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.height*.022,
                            color: ColorManager.white
                        ),),
                      ),

                    ],
                  ),
                )
              ],
            ),
          );
        },
        listener: (context,state){

        }
    );
  }
}
