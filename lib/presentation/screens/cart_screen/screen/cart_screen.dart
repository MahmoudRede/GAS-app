import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gas/business_logic/app_cubit/app_cubit.dart';
import 'package:gas/business_logic/app_cubit/app_states.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/presentation/screens/cart_screen/widgets/favorite_widget.dart';
import 'package:gas/presentation/screens/cart_screen/widgets/order_widget.dart';
import 'package:gas/presentation/screens/order_screen/screen/order_screen.dart';
import 'package:gas/presentation/widgets/button_widget.dart';
import 'package:gas/style/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

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
              title: Text(AppLocalizations.of(context)!.translate('yourCart').toString(),style: GoogleFonts.almarai(
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.height*.027,
                  color: ColorManager.black
              ),),
            ),
            body: Column(
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

                      // order summary
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            cubit.switchBetweenOrderAndFavorite();
                          },
                          child: Container(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.height*.017),
                            decoration: BoxDecoration(
                              color: cubit.isFavorite?Colors.transparent:ColorManager.white,
                              borderRadius: BorderRadius.circular(7)

                            ),
                            child: Text(AppLocalizations.of(context)!.translate('orderSummary').toString(),style: GoogleFonts.almarai(
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

                      // favorites
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            cubit.switchBetweenOrderAndFavorite();
                          },
                          child: Container(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.height*.017),
                            decoration: BoxDecoration(
                                color: cubit.isFavorite==false?Colors.transparent:ColorManager.white,
                                borderRadius: BorderRadius.circular(7)

                            ),
                            child: Text(AppLocalizations.of(context)!.translate('favorites').toString(),style: GoogleFonts.almarai(
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
                cubit.isFavorite==false?
                cubit.allSelected.isNotEmpty?
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context,index){
                        return  OrderWidget(index: index);
                      },
                      separatorBuilder: (context,index){
                        return const SizedBox(height: 10,);
                      },
                      itemCount: cubit.allSelected.length
                  ),
                ):
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   SizedBox(height: MediaQuery.of(context).size.height*0.15,),
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

                    Text(
                      AppLocalizations.of(context)!.translate('orderEmpty').toString(),
                      style: GoogleFonts.almarai(
                      color: ColorManager.black,
                      fontWeight: FontWeight.w700,
                      fontSize: MediaQuery.of(context).size.height*0.025,),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ):
                cubit.allFavorite.isNotEmpty?
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context,index){
                        return FavoriteWidget(index:index);
                      },
                      separatorBuilder: (context,index){
                        return const SizedBox(height: 10,);
                      },
                      itemCount:cubit.allFavorite.length
                  ),
                ):
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.15,),
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

                    Text(
                      AppLocalizations.of(context)!.translate('orderEmpty').toString(),
                      style: GoogleFonts.almarai(
                        color: ColorManager.black,
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height*0.025,),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height*.02,),
                
                if(cubit.isFavorite==false && cubit.allSelected.isNotEmpty)
                  Padding(
                    padding:  EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height*.02,
                      vertical:MediaQuery.of(context).size.height*.01,
                    ),
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

                              Navigator.push(context, MaterialPageRoute(builder: (_){
                                 return OrderScreen();
                              }));

                            },
                            child: Text(AppLocalizations.of(context)!.translate('continue').toString(),style: GoogleFonts.almarai(fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context).size.height*.022,
                                color: ColorManager.white
                            ),),
                          ),
                        ),
                      ],
                    ),
                  )


              ],
            ),
         );
      },

    );
  }
}
