
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gas/business_logic/app_cubit/app_cubit.dart';
import 'package:gas/business_logic/app_cubit/app_states.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/presentation/screens/driver_login/screen/driver_register.dart';
import 'package:gas/presentation/screens/driver_screen/screen/driver_screen.dart';
import 'package:gas/presentation/screens/driver_screen/screen/view_driver_request.dart';
import 'package:gas/presentation/widgets/default_text_field.dart';
import 'package:gas/presentation/widgets/toast.dart';
import 'package:gas/style/app_color.dart';
import 'package:gas/utils/local/cash_helper.dart';
import 'package:google_fonts/google_fonts.dart';


class DriverLoginScreen extends StatefulWidget {
  const DriverLoginScreen({super.key});

  @override
  State<DriverLoginScreen> createState() => _DriverLoginScreenState();
}

class _DriverLoginScreenState extends State<DriverLoginScreen> {

  var formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isPassword=false;
  late String phoneNumber;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){

          if(state is UserLoginSuccessState){

            Navigator.push(context, MaterialPageRoute(builder: (_){

              return const DriverScreen();

            }));
          }

          if(state is UserLoginErrorState){

            customToast(title: AppLocalizations.of(context)!.translate('loginToast').toString(), color: ColorManager.red);

          }




        },
        builder: (context,state){
          var cubit=AppCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.primaryColor,
            body: SafeArea(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .04,),

                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30, left: 30, right: 30),
                        child: Image.asset(
                          'assets/images/gas.png',
                          height: MediaQuery.of(context).size.height * .16,
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * .013,),


                      Text(AppLocalizations.of(context)!.translate('appName').toString(),style: GoogleFonts.almarai(
                          fontWeight: FontWeight.w700,
                          fontSize: MediaQuery.of(context).size.height*.03,
                          color: ColorManager.black),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * .013,),

                      Text('أنت أطلب و إحنا نوصل',style: GoogleFonts.almarai(
                          fontWeight: FontWeight.w300,
                          fontSize: MediaQuery.of(context).size.height*.027,
                          color: ColorManager.black),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * .06,),


                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * .02),
                        child: DefaultTextField(
                          hintText: AppLocalizations.of(context)!.translate('email').toString(),
                          controller: email,
                          isPass: false,
                          prefixIcon: Icons.person,
                          textInputType: TextInputType.text,
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * .035,),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * .02),
                        child: DefaultTextField(
                          hintText: AppLocalizations.of(context)!.translate('password').toString(),
                          controller: password,
                          prefixIcon: Icons.lock,
                          isPass: true,
                          textInputType: TextInputType.text,
                        ),
                      ),

                      SizedBox(
                        height: size.height * .04,
                      ),

                      state is UserLoginLoadingState?
                      Center(
                        child: CircularProgressIndicator(color: ColorManager.black,),
                      ):
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: CashHelper.getData(key: CashHelper.languageKey).toString() == 'en'?MediaQuery.of(context).size.height*.2:MediaQuery.of(context).size.height*.155,
                          vertical: MediaQuery.of(context).size.height*.018,
                        ),
                        color: ColorManager.buttonColor,
                        onPressed: (){

                          if(formKey.currentState!.validate()){

                            cubit.userLogin(
                                email: email.text,
                                password: password.text
                            );

                          }


                        },
                        child:Text(AppLocalizations.of(context)!.translate('login').toString(),style: GoogleFonts.almarai(
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.height*.022,
                            color: ColorManager.white
                        ),),
                      ),


                      SizedBox(
                        height: size.height * .04,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalizations.of(context)!.translate('registerMessage').toString(),style: GoogleFonts.almarai(
                              fontWeight: FontWeight.w300,
                              fontSize: CashHelper.getData(key: CashHelper.languageKey).toString() == 'en'?MediaQuery.of(context).size.height*.022:MediaQuery.of(context).size.height*.025,
                              color: ColorManager.black),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(
                            width: size.height * .007,
                          ),

                          GestureDetector(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (_){

                                return const DriverRegisterScreen();

                              }));

                            },
                            child: Text(AppLocalizations.of(context)!.translate('register').toString(),style: GoogleFonts.almarai(
                                fontWeight: FontWeight.w700,
                                fontSize: CashHelper.getData(key: CashHelper.languageKey).toString() == 'en'?MediaQuery.of(context).size.height*.022:MediaQuery.of(context).size.height*.025,
                                color: ColorManager.textColor
                            ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height *.02),


                      TextButton(
                        onPressed: (){
                          cubit.getUser(id: 'NFbh7U5BonVDKTIjT2t1');

                          Navigator.push(context, MaterialPageRoute(builder: (_){

                            return const DriverScreen();

                          }));
                          showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => AlertDialog(
                              title: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image(
                                    height: MediaQuery.of(context).size.height*.07,
                                    width: MediaQuery.of(context).size.height*.04,
                                    image: const AssetImage('assets/images/warning.png')
                                ),
                              ),
                              content: Container(
                                height: MediaQuery.of(context).size.height*.15,
                                child: Column(
                                  children: [
                                    Text(AppLocalizations.of(context)!.translate('warningToast').toString(),style: GoogleFonts.almarai(
                                        color: ColorManager.textColor,
                                        fontSize: 16
                                    ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height*.03,),
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(7)
                                      ),
                                      color: ColorManager.red,
                                      onPressed: (){
                                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                            DriverLoginScreen()), (Route<dynamic> route) => false);
                                      },
                                      child: Text(AppLocalizations.of(context)!.translate('registerTitle').toString(),style: GoogleFonts.almarai(
                                          color: ColorManager.white,
                                          fontSize: 16
                                      ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                            ),
                          );

                        },
                        child: Text(
                            AppLocalizations.of(context)!.translate('loginAsAGuest').toString(),
                          style: GoogleFonts.almarai(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.textColor,
                              decoration: TextDecoration.underline
                          ),
                        ),
                      ),


                      // GestureDetector(
                      //   onTap: (){
                      //
                      //     Navigator.push(context, MaterialPageRoute(builder: (_){
                      //
                      //       return const ViewDriverRequestScreen();
                      //
                      //     }));
                      //
                      //   },
                      //   child: Text(AppLocalizations.of(context)!.translate('admin').toString(),style: GoogleFonts.almarai(
                      //       fontWeight: FontWeight.w700,
                      //       fontSize: CashHelper.getData(key: CashHelper.languageKey).toString() == 'en'?MediaQuery.of(context).size.height*.022:MediaQuery.of(context).size.height*.025,
                      //       color: ColorManager.textColor
                      //   ),
                      //     textAlign: TextAlign.center,
                      //   ),
                      // ),






                    ],
                  ),
                ),
              ),
            ),
          );

        },

    );
  }

}