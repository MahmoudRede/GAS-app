import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gas/business_logic/app_cubit/app_cubit.dart';
import 'package:gas/business_logic/app_cubit/app_states.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/presentation/screens/driver_screen/widget/driver_widget.dart';
import 'package:gas/presentation/screens/driver_screen/widget/my_order_widget.dart';
import 'package:gas/presentation/screens/driver_screen/widget/user_widget.dart';
import 'package:gas/style/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ViewDriverRequestScreen extends StatelessWidget {
  const ViewDriverRequestScreen({Key? key}) : super(key: key);

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
            title: Text(AppLocalizations.of(context)!.translate('viewDriverRequest').toString(),style: GoogleFonts.almarai(
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.height*.027,
                color: ColorManager.black
            ),),
          ),
          body: Column(
            children: [

              SizedBox(height: MediaQuery.of(context).size.height*.02,),

              cubit.allDrivers.isNotEmpty?
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context,index){
                      return DriverWidget(index: index);
                    },
                    separatorBuilder: (context,index){
                      return const SizedBox(height: 10,);
                    },
                    itemCount:cubit.allDrivers.length
                ),
              ) :
              Container(
                width: double.infinity,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
              ),

              SizedBox(height: MediaQuery.of(context).size.height*.02,),

            ],
          )

        );
      },

    );
  }
}
