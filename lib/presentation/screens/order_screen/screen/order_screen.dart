import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gas/business_logic/app_cubit/app_cubit.dart';
import 'package:gas/business_logic/app_cubit/app_states.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/presentation/screens/cart_screen/widgets/favorite_widget.dart';
import 'package:gas/presentation/screens/cart_screen/widgets/order_widget.dart';
import 'package:gas/presentation/widgets/default_text_field.dart';
import 'package:gas/style/app_color.dart';
import 'package:gas/utils/local/cash_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends StatelessWidget {

  @override
  var formKey =GlobalKey<FormState>();
    OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit=AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: ColorManager.black,
                size: MediaQuery.of(context).size.height*.03,
              ),
            ),
            titleSpacing: 0.0,
            title: Text(AppLocalizations.of(context)!.translate('contactDetails').toString(),style: GoogleFonts.almarai(
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.height*.027,
                color: ColorManager.black
            ),),
          ),
          body: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*.02),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    SizedBox(height: MediaQuery.of(context).size.height*.01,),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context)!.translate('total').toString(),style: GoogleFonts.almarai(
                                  fontWeight: FontWeight.w700,
                                  fontSize: MediaQuery.of(context).size.height*.027,
                                  color: ColorManager.black
                              ),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height*.005,),

                              Text('${cubit.totalPrice} ${AppLocalizations.of(context)!.translate('saR').toString()}',style: GoogleFonts.almarai(
                                  fontWeight: FontWeight.w700,
                                  fontSize: MediaQuery.of(context).size.height*.022,
                                  color: ColorManager.textColor
                              ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),

                          SizedBox(width:MediaQuery.of(context).size.height*.025 ,),

                          state is UploadOrderLoadingState|| state is UploadUserLoadingState?
                          Expanded(child: Center(child: CircularProgressIndicator(color: ColorManager.primaryColor,))):
                          Expanded(
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height*.02,
                              ),
                              color: ColorManager.buttonColor,
                              onPressed: (){

                                if(formKey.currentState!.validate()){

                                  if(CashHelper.getData(key: 'userUid')==null){
                                    int randomNumber = Random().nextInt(10000000) + 0;

                                    CashHelper.saveData(key: 'userUid',value: randomNumber);

                                  }

                                  cubit.uploadOrder(
                                      context: context,
                                      firstName: cubit.firstName.text,
                                      lastName: cubit.lastName.text,
                                      email: cubit.email.text,
                                      address: cubit.address.text,
                                      location: cubit.location.text,
                                      phoneNumber: cubit.phoneNumber.text,
                                      uId: CashHelper.getData(key: 'userUid',),

                                  );



                                }

                              },
                              child: Text(AppLocalizations.of(context)!.translate('proceedToPay').toString(),style: GoogleFonts.almarai(fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context).size.height*.022,
                                  color: ColorManager.white
                              ),),
                            ),
                          ),
                        ],
                      ),
                    ),


                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: MediaQuery.of(context).size.height*.02,),

                          Text(AppLocalizations.of(context)!.translate('firstName').toString(),style: GoogleFonts.almarai(
                              fontWeight: FontWeight.w700,
                              fontSize: MediaQuery.of(context).size.height*.025,
                              color: ColorManager.black
                          ),),
                          SizedBox(height: MediaQuery.of(context).size.height*.015,),
                          DefaultTextField(
                              hintText: '',
                              prefixIcon: Icons.person,
                              controller: cubit.firstName,
                              textInputType: TextInputType.name,
                          ),


                          SizedBox(height: MediaQuery.of(context).size.height*.02,),


                          Text(AppLocalizations.of(context)!.translate('lastName').toString(),style: GoogleFonts.almarai(
                              fontWeight: FontWeight.w700,
                              fontSize: MediaQuery.of(context).size.height*.025,
                              color: ColorManager.black
                          ),),
                          SizedBox(height: MediaQuery.of(context).size.height*.015,),
                          DefaultTextField(
                            hintText: '',
                            prefixIcon: Icons.person,
                            controller: cubit.lastName,
                            textInputType: TextInputType.name,
                          ),


                          SizedBox(height: MediaQuery.of(context).size.height*.02,),


                          Text(AppLocalizations.of(context)!.translate('address').toString(),style: GoogleFonts.almarai(
                              fontWeight: FontWeight.w700,
                              fontSize: MediaQuery.of(context).size.height*.025,

                              color: ColorManager.black
                          ),),
                          SizedBox(height: MediaQuery.of(context).size.height*.015,),
                          DefaultTextField(
                            hintText: '',
                            prefixIcon: Icons.location_on_rounded,
                            controller: cubit.address,
                            textInputType: TextInputType.text,
                          ),


                          SizedBox(height: MediaQuery.of(context).size.height*.02,),


                          Text(AppLocalizations.of(context)!.translate('shareYourLocation').toString(),style: GoogleFonts.almarai(
                              fontWeight: FontWeight.w700,
                              fontSize: MediaQuery.of(context).size.height*.025,

                              color: ColorManager.black
                          ),),
                          SizedBox(height: MediaQuery.of(context).size.height*.015,),
                          DefaultTextField(
                            hintText: '',
                            prefixIcon: Icons.my_location_outlined,
                            controller: cubit.location,
                            textInputType: TextInputType.text,
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*.02,),

                          Text(AppLocalizations.of(context)!.translate('email').toString(),style: GoogleFonts.almarai(
                              fontWeight: FontWeight.w700,
                              fontSize: MediaQuery.of(context).size.height*.025,
                              color: ColorManager.black
                          ),),
                          SizedBox(height: MediaQuery.of(context).size.height*.015,),
                          DefaultTextField(
                            hintText: '',
                            prefixIcon: Icons.email,
                            controller: cubit.email,
                            textInputType: TextInputType.emailAddress,
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*.02,),

                          Text(AppLocalizations.of(context)!.translate('phoneNumber').toString(),style: GoogleFonts.almarai(
                              fontWeight: FontWeight.w700,
                              fontSize: MediaQuery.of(context).size.height*.025,

                              color: ColorManager.black
                          ),),
                          SizedBox(height: MediaQuery.of(context).size.height*.015,),
                          DefaultTextField(
                            hintText: '',
                            prefixIcon: Icons.phone,
                            controller: cubit.phoneNumber,
                            textInputType: TextInputType.phone,
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*.1,),

                        ],
                      ),
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
