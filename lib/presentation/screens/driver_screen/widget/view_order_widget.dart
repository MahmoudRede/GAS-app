import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gas/business_logic/app_cubit/app_cubit.dart';
import 'package:gas/business_logic/app_cubit/app_states.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/style/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewOrderWidget extends StatelessWidget {
  final int index;
  const ViewOrderWidget({Key? key,required this.index}) : super(key: key);

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
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: ColorManager.white),
                borderRadius: BorderRadius.circular(7)
            ),
            child: Row(
              children: [

                // Image
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child: Image(
                    image:  NetworkImage(cubit.allOrders[index].image!),
                    height: MediaQuery.of(context).size.height*.17,
                    width: MediaQuery.of(context).size.height*.17,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(width: MediaQuery.of(context).size.height*.02,),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height*.015,),

                                Text(cubit.allOrders[index].title!,style: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w300,
                                    fontSize: MediaQuery.of(context).size.height*.022,
                                    color: ColorManager.textColor
                                ),
                                  textAlign: TextAlign.center,
                                ),

                                SizedBox(height: MediaQuery.of(context).size.height*.02,),

                                Text('${cubit.allOrders[index].price} ${AppLocalizations.of(context)!.translate('saR').toString()}',style: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w700,
                                    fontSize: MediaQuery.of(context).size.height*.022,
                                    color: ColorManager.textColor
                                ),
                                  textAlign: TextAlign.center,
                                ),

                                SizedBox(height: MediaQuery.of(context).size.height*.02,),

                                Text('${cubit.allOrders[index].number}',style: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w700,
                                    fontSize: MediaQuery.of(context).size.height*.022,
                                    color: ColorManager.textColor
                                ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*.02,),

                    ],
                  ),
                ),

              ],
            ),
          )
        );
      },
    );

  }
}
