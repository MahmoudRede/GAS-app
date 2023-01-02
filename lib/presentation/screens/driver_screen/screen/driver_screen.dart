import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gas/business_logic/app_cubit/app_cubit.dart';
import 'package:gas/business_logic/app_cubit/app_states.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/presentation/screens/driver_screen/widget/my_order_widget.dart';
import 'package:gas/presentation/screens/driver_screen/widget/user_widget.dart';
import 'package:gas/style/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class DriverScreen extends StatelessWidget {
  const DriverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit=AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,

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
            title: Text(AppLocalizations.of(context)!.translate('driverScreen').toString(),style: GoogleFonts.almarai(
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.height*.027,
                color: ColorManager.black
            ),),
          ),
          body: cubit.driverModel !=null?
          cubit.driverModel!.isVerified==true?
          Column(
            children: [

              SizedBox(height: MediaQuery.of(context).size.height*.02,),

              Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height*.006),
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*.012),
                decoration: BoxDecoration(
                    color: ColorManager.toolbarColor,
                    border: Border.all(color: ColorManager.white),
                    borderRadius: BorderRadius.circular(7)
                ),
                child: Row(
                  children: [

                    // all order
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          cubit.switchBetweenOrderAndMyOrders();
                        },
                        child: Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*.017),
                          decoration: BoxDecoration(
                              color: cubit.isOrder?Colors.transparent:ColorManager.white,
                              borderRadius: BorderRadius.circular(7)

                          ),
                          child: Text('${AppLocalizations.of(context)!.translate('allOrders').toString()}',style: GoogleFonts.almarai(
                              fontWeight: FontWeight.w300,
                              fontSize: MediaQuery.of(context).size.height*.022,
                              color: ColorManager.black
                          ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: MediaQuery.of(context).size.height*.01,),

                    // My orders
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          cubit.switchBetweenOrderAndMyOrders();
                        },
                        child: Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*.017),
                          decoration: BoxDecoration(
                              color: cubit.isOrder==false?Colors.transparent:ColorManager.white,
                              borderRadius: BorderRadius.circular(7)

                          ),
                          child: Text('${AppLocalizations.of(context)!.translate('myOrders').toString()}',style: GoogleFonts.almarai(
                              fontWeight: FontWeight.w300,
                              fontSize: MediaQuery.of(context).size.height*.022,
                              color: ColorManager.black
                          ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height*.02,),

              cubit.isOrder==false?
              cubit.allUsers.isNotEmpty?
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context,index){
                      return UserWidget(index: index);
                    },
                    separatorBuilder: (context,index){
                      return const SizedBox(height: 10,);
                    },
                    itemCount:cubit.allUsers.length
                ),
              ) :
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.15,),
                  // image
                  SizedBox(
                    width: MediaQuery.of(context).size.height*0.25,
                    height: MediaQuery.of(context).size.height*0.25,
                    child:Lottie.asset(
                      "assets/images/empty_list.json",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.height*0.35,
                      height: MediaQuery.of(context).size.height*0.35,
                    ),
                  ),

                  // title
                  Text(
                    AppLocalizations.of(context)!.translate('orderEmpty').toString(),
                    style: GoogleFonts.almarai(
                      color: ColorManager.black,
                      fontWeight: FontWeight.w700,
                      fontSize: MediaQuery.of(context).size.height*0.025,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ):
              cubit.selectedOrders.isNotEmpty?
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context,index){
                      return MyOrderWidget(index:index);
                    },
                    separatorBuilder: (context,index){
                      return const SizedBox(height: 10,);
                    },
                    itemCount:cubit.selectedOrders.length
                ),
              ):
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.15,),
                  // image
                  SizedBox(
                    width: MediaQuery.of(context).size.height*0.25,
                    height: MediaQuery.of(context).size.height*0.25,
                    child:Lottie.asset(
                      "assets/images/empty_list.json",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.height*0.35,
                      height: MediaQuery.of(context).size.height*0.35,
                    ),
                  ),

                  // title
                  Text(
                    AppLocalizations.of(context)!.translate('orderEmpty').toString(),
                    style: GoogleFonts.almarai(
                      color: ColorManager.black,
                      fontWeight: FontWeight.w700,
                      fontSize: MediaQuery.of(context).size.height*0.025,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height*.02,),

            ],
          ):
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: MediaQuery.of(context).size.height*.06,),

                // title

                // Lottie Image
                Lottie.asset('assets/images/waiting_image.json',height: MediaQuery.of(context).size.height*.5,width:MediaQuery.of(context).size.height*.45),

                // Text
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height*.03
                  ),
                  child: Text(AppLocalizations.of(context)!.translate('waiting').toString(),
                    style: GoogleFonts.almarai(
                        color: ColorManager.textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.height*.022
                    ),
                    textAlign: TextAlign.center,
                  ),
                )


              ],
            ),
          ):
          Center(
            child: CircularProgressIndicator(color: ColorManager.black,),
          ),
        );
      },

    );
  }
}
