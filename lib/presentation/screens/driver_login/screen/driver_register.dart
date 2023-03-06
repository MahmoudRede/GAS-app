
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gas/business_logic/app_cubit/app_cubit.dart';
import 'package:gas/business_logic/app_cubit/app_states.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/presentation/screens/driver_screen/screen/driver_screen.dart';
import 'package:gas/presentation/widgets/default_text_field.dart';
import 'package:gas/presentation/widgets/toast.dart';
import 'package:gas/style/app_color.dart';
import 'package:gas/utils/local/cash_helper.dart';
import 'package:google_fonts/google_fonts.dart';


class DriverRegisterScreen extends StatefulWidget {
  const DriverRegisterScreen({super.key});

  @override
  State<DriverRegisterScreen> createState() => _DriverRegisterScreenState();
}

class _DriverRegisterScreenState extends State<DriverRegisterScreen> {

  var formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
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
              if(state is UserRegisterSuccessState){

                Navigator.pop(context);

              }

              if(state is UserRegisterErrorState){

                customToast(title: AppLocalizations.of(context)!.translate('registerToast').toString(), color: ColorManager.red);

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

                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0, left: 30, right: 30),
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

                      SizedBox(height: MediaQuery.of(context).size.height * .04,),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * .02),
                        child: DefaultTextField(
                          hintText: AppLocalizations.of(context)!.translate('name').toString(),
                          controller: name,
                          isPass: false,
                          prefixIcon: Icons.person,
                          textInputType: TextInputType.text,
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * .025,),

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

                      SizedBox(height: MediaQuery.of(context).size.height * .025,),

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

                      SizedBox(height: MediaQuery.of(context).size.height * .025,),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * .02),
                        child: DefaultTextField(
                          hintText: AppLocalizations.of(context)!.translate('phoneNumber').toString(),
                          controller: phone,
                          prefixIcon: Icons.phone,
                          isPass: false,
                          textInputType: TextInputType.phone,
                        ),
                      ),

                      SizedBox(
                        height: size.height * .04,
                      ),

                      state is SaveUserLoadingState|| state is UserRegisterLoadingState?
                      Center(
                        child: CircularProgressIndicator(color: ColorManager.black,),
                      ):
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: CashHelper.getData(key: CashHelper.languageKey).toString() == 'en'?MediaQuery.of(context).size.height*.182:MediaQuery.of(context).size.height*.155,
                          vertical: MediaQuery.of(context).size.height*.018,
                        ),
                        color: ColorManager.buttonColor,
                        onPressed: (){

                          if(formKey.currentState!.validate()){


                            if(formKey.currentState!.validate()){

                              cubit.userRegister(
                                  email: email.text,
                                  password: password.text,
                                  name: name.text,
                                  phoneNumber: phone.text
                              );

                            }



                          }

                        },
                        child:Text(AppLocalizations.of(context)!.translate('registerTitle').toString(),style: GoogleFonts.almarai(
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.height*.022,
                            color: ColorManager.white
                        ),),
                      ),

                      SizedBox(
                        height: size.height * .04,
                      ),



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