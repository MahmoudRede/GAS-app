import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gas/business_logic/app_cubit/app_cubit.dart';
import 'package:gas/business_logic/app_cubit/app_states.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/presentation/screens/cart_screen/widgets/favorite_widget.dart';
import 'package:gas/presentation/screens/cart_screen/widgets/order_widget.dart';
import 'package:gas/presentation/screens/driver_screen/widget/user_widget.dart';
import 'package:gas/presentation/screens/driver_screen/widget/view_order_widget.dart';
import 'package:gas/style/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewOrderScreen extends StatelessWidget {
  const ViewOrderScreen({Key? key}) : super(key: key);

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
            title: Text(AppLocalizations.of(context)!.translate('viewOrder').toString(),style: GoogleFonts.almarai(
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.height*.027,
                color: ColorManager.black
            ),),
          ),
          body: Column(
            children: [

              SizedBox(height: MediaQuery.of(context).size.height*.02,),

              Expanded(
                child: ListView.separated(
                    itemBuilder: (context,index){
                      return ViewOrderWidget(index:index);
                    },
                    separatorBuilder: (context,index){
                      return const SizedBox(height: 10,);
                    },
                    itemCount:cubit.allOrders.length
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height*.02,),




            ],
          ),
        );
      },

    );
  }
}
