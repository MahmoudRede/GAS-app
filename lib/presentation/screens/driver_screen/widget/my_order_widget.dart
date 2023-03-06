import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gas/business_logic/app_cubit/app_cubit.dart';
import 'package:gas/business_logic/app_cubit/app_states.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/presentation/widgets/toast.dart';
import 'package:gas/style/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrderWidget extends StatelessWidget {
  final int index;
  const MyOrderWidget({Key? key,required this.index}) : super(key: key);

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
                color: ColorManager.toolbarColor,
                border: Border.all(color: ColorManager.white),
                borderRadius: BorderRadius.circular(7)
            ),
            child: Column(
              children: [

                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Checkbox(
                        value: cubit.isDone[index],
                        onChanged: (value){
                          cubit.deleteOrder(id: int.parse(cubit.selectedOrders[index]['favorite']));
                          // cubit.doneUserOrder(id:int.parse(cubit.selectedOrders[index]['favorite']) );
                          cubit.orderDone(value,index);
                          cubit.deleteSelectedOrdersDatabase(name: cubit.selectedOrders[index]['name'],context: context);
                          customToast(title:AppLocalizations.of(context)!.translate('orderArrived').toString(), color: Colors.red);
                          cubit.isDone=List.generate(100, (index) => false);
                        }
                    ),
                  ) ,
                ),

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
                      child: Text(cubit.selectedOrders[index]['name'],style: GoogleFonts.almarai(
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
                      child: Text(cubit.selectedOrders[index]['address'],style: GoogleFonts.almarai(
                          fontWeight: FontWeight.w700,
                          fontSize: MediaQuery.of(context).size.height*.024,
                          color: ColorManager.black
                      ),
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
                        color: ColorManager.textColor
                    ),
                        textAlign: TextAlign.center,
                    ),

                    SizedBox(width: MediaQuery.of(context).size.height*.01,),

                    Expanded(
                      child: Text(cubit.selectedOrders[index]['price'],style: GoogleFonts.almarai(
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          fontSize: MediaQuery.of(context).size.height*.024,
                          color: ColorManager.black
                      ),
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
                      child: Text(cubit.selectedOrders[index]['rate'],style: GoogleFonts.almarai(
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
                      child: Text(cubit.selectedOrders[index]['image'],style: GoogleFonts.almarai(
                          fontWeight: FontWeight.w700,
                          fontSize: MediaQuery.of(context).size.height*.024,
                          color: ColorManager.black),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height*.01,),

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
                          color: ColorManager.primaryColor,
                          onPressed: (){

                            cubit.getOrders(id: cubit.allUsers[index].uId!,context: context);

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

                    // Expanded(
                    //   child: SizedBox(
                    //     width: double.infinity,
                    //     child: MaterialButton(
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(7)
                    //       ),
                    //       padding: EdgeInsets.symmetric(
                    //         vertical: MediaQuery.of(context).size.height*.018,
                    //       ),
                    //       color: ColorManager.buttonColor,
                    //       onPressed: (){
                    //
                    //         cubit.unSelectedUserOrder(id: int.parse(cubit.selectedOrders[index]['favorite']));
                    //         cubit.deleteSelectedOrdersDatabase(name: cubit.selectedOrders[index]['name'],context: context);
                    //
                    //       },
                    //       child: Text(AppLocalizations.of(context)!.translate('remove').toString(),style: GoogleFonts.almarai(
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: MediaQuery.of(context).size.height*.022,
                    //           color: ColorManager.white
                    //       ),),
                    //     ),
                    //   ),
                    // ),
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
