import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gas/business_logic/app_cubit/app_cubit.dart';
import 'package:gas/business_logic/app_cubit/app_states.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/style/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class UserWidget extends StatelessWidget {
  final int index;
  const UserWidget({Key? key,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit=AppCubit.get(context);
        return Container(
          margin: EdgeInsets.all( MediaQuery.of(context).size.height*.01),
          decoration: const BoxDecoration(
              color: Colors.transparent
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*.01),
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height*.01,
                vertical: MediaQuery.of(context).size.height*.01,
            ),
            decoration: BoxDecoration(
                color: cubit.allUsers[index].selected!?Colors.grey[700]:ColorManager.toolbarColor,
                border: Border.all(color: ColorManager.white),
                borderRadius: BorderRadius.circular(7)
            ),
            child: Column(
              children: [

                Row(
                  children: [
                    Text('${AppLocalizations.of(context)!.translate('email').toString()} :',style: GoogleFonts.almarai(
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height*.024,
                        color: ColorManager.textColor),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(width: MediaQuery.of(context).size.height*.01,),

                    Expanded(
                      child: Text(cubit.allUsers[index].email!,style: GoogleFonts.almarai(
                          fontWeight: FontWeight.w700,
                          fontSize: MediaQuery.of(context).size.height*.024,
                          color: ColorManager.black),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height*.02,),

                Row(
                  children: [
                    Text('${AppLocalizations.of(context)!.translate('name').toString()} :',style: GoogleFonts.almarai(
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height*.024,
                        color: ColorManager.textColor),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(width: MediaQuery.of(context).size.height*.01,),

                    Expanded(
                      child: Text('${cubit.allUsers[index].firstName!}  ${cubit.allUsers[index].lastName!}',style: GoogleFonts.almarai(
                          fontWeight: FontWeight.w700,
                          fontSize: MediaQuery.of(context).size.height*.024,
                          color: ColorManager.black),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height*.02,),

                Row(
                  children: [
                    Text('${AppLocalizations.of(context)!.translate('address').toString()} :',style: GoogleFonts.almarai(
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height*.024,
                        color: ColorManager.textColor),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(width: MediaQuery.of(context).size.height*.01,),

                    Expanded(
                      child: Text(cubit.allUsers[index].address!,style: GoogleFonts.almarai(
                          fontWeight: FontWeight.w700,
                          fontSize: MediaQuery.of(context).size.height*.024,
                          color: ColorManager.black),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height*.02,),

                Row(
                  children: [
                    Text('${AppLocalizations.of(context)!.translate('phoneNumber').toString()} :',style: GoogleFonts.almarai(
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height*.024,
                        color: ColorManager.textColor),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(width: MediaQuery.of(context).size.height*.01,),

                    Expanded(
                      child: Text(cubit.allUsers[index].phoneNumber!,style: GoogleFonts.almarai(
                          fontWeight: FontWeight.w700,
                          fontSize: MediaQuery.of(context).size.height*.024,
                          color: ColorManager.black),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height*.02,),

                Row(
                  children: [
                    Text('${AppLocalizations.of(context)!.translate('total').toString()} :',style: GoogleFonts.almarai(
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height*.024,
                        color: ColorManager.textColor),
                    ),

                    SizedBox(width: MediaQuery.of(context).size.height*.01,),

                    Expanded(
                      child: Text('${cubit.allUsers[index].totalPrice}',style: GoogleFonts.almarai(
                          fontWeight: FontWeight.w700,
                          fontSize: MediaQuery.of(context).size.height*.024,
                          color: ColorManager.black),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height*.01,),

                if(cubit.allUsers[index].selected ==false)
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height*.018,
                          ),

                          // ttt
                          color: ColorManager.primaryColor,
                          onPressed: (){

                            if(cubit.driverModel!.uId=='HtjmznoitMXJuRoNeDviXhMkh7A3'){
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image(
                                        height: MediaQuery.of(context).size.height*.07,
                                        width: MediaQuery.of(context).size.height*.04,
                                        image: const AssetImage('assets/images/warning.png')
                                    ),
                                  ),
                                  content: Text(AppLocalizations.of(context)!.translate('warningToast').toString(),style: GoogleFonts.almarai(
                                      color: ColorManager.textColor,
                                      fontSize: 16
                                  ),
                                    textAlign: TextAlign.center,
                                  ),

                                ),
                              );
                            }else{

                              cubit.getOrders(id: cubit.allUsers[index].uId!,context: context);

                            }

                          },
                          child: Text(AppLocalizations.of(context)!.translate('openOrder').toString(),style: GoogleFonts.almarai(
                              fontWeight: FontWeight.w600,
                              fontSize: MediaQuery.of(context).size.height*.022,
                              color: ColorManager.white
                          ),),
                        ),
                      ),
                    ),

                    SizedBox(width: MediaQuery.of(context).size.height*.01,),

                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height*.018,
                          ),
                          color: ColorManager.buttonColor,
                          onPressed: (){

                            if(cubit.driverModel!.uId=='HtjmznoitMXJuRoNeDviXhMkh7A3'){
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image(
                                        height: MediaQuery.of(context).size.height*.07,
                                        width: MediaQuery.of(context).size.height*.04,
                                        image: const AssetImage('assets/images/warning.png')
                                    ),
                                  ),
                                  content: Text(AppLocalizations.of(context)!.translate('warningToast').toString(),style: GoogleFonts.almarai(
                                      color: ColorManager.textColor,
                                      fontSize: 16
                                  ),
                                    textAlign: TextAlign.center,
                                  ),

                                ),
                              );
                            }else{
                              cubit.selectedUserOrder(
                                  id: cubit.allUsers[index].uId!,
                                  email: cubit.allUsers[index].email!,
                                  firstName: '${cubit.allUsers[index].firstName!}  ${cubit.allUsers[index].lastName!}',
                                  address: cubit.allUsers[index].address!,
                                  phoneNumber: cubit.allUsers[index].phoneNumber!,
                                  totalPrice:cubit.allUsers[index].totalPrice!
                              );
                            }

                          },
                          child: Text(AppLocalizations.of(context)!.translate('select').toString(),style: GoogleFonts.almarai(
                              fontWeight: FontWeight.w600,
                              fontSize: MediaQuery.of(context).size.height*.022,
                              color: ColorManager.white
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),



              ],
            ),
          ),
        );
      },
    );

  }
}
