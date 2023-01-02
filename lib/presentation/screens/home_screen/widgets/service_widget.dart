import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gas/business_logic/app_cubit/app_cubit.dart';
import 'package:gas/business_logic/app_cubit/app_states.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/data/models/service_model.dart';
import 'package:gas/presentation/widgets/button_widget.dart';
import 'package:gas/style/app_color.dart';
import 'package:gas/utils/local/cash_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceWidget extends StatefulWidget {
  final ServiceModel serviceModel;
  final int index;
  const ServiceWidget({Key? key,required this.serviceModel,required this.index}) : super(key: key);

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=AppCubit.get(context);
          return cubit.services.isNotEmpty?
          Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*.01),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              border: Border.all(color: ColorManager.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    // Image
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Image(
                        image: NetworkImage(widget.serviceModel.image!),
                        height: MediaQuery.of(context).size.height*.2,
                        width: MediaQuery.of(context).size.height*.3,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Positioned(
                      top: MediaQuery.of(context).size.height*.00,
                      right: MediaQuery.of(context).size.height*.00,
                      child: IconButton(
                          onPressed: (){
                            if(CashHelper.getData(key: '${widget.serviceModel.title!}')==false || CashHelper.getData(key: '${widget.serviceModel.title!}')==null){
                              cubit.changeFavoriteColorToTrue(name: widget.serviceModel.title!);
                              cubit.additionalChangeColor(index: widget.index);
                              cubit.insertDatabase(name: '${widget.serviceModel.title}', price: '${widget.serviceModel.price}', rate: 'no', image: '${widget.serviceModel.image}',address: 'yes',context: context);
                            }
                            else{
                              cubit.changeFavoriteColorToFalse(name: widget.serviceModel.title!);
                              cubit.additionalChangeColor(index: widget.index);
                              cubit.deleteDatabase(name: widget.serviceModel.title!,context: context);
                            }

                          },
                          icon: CashHelper.getData(key: '${widget.serviceModel.title!}')==null|| CashHelper.getData(key: '${widget.serviceModel.title!}')==false ? Icon(
                              Icons.favorite_border,
                              color: ColorManager.black,
                          ):Icon(
                            Icons.favorite,
                            color: ColorManager.red,
                          )
                      ),
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height*.025,),

                Text(widget.serviceModel.title!,style: GoogleFonts.almarai(
                    fontWeight: FontWeight.w300,
                    fontSize: MediaQuery.of(context).size.height*.022,
                    color: ColorManager.textColor
                ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: MediaQuery.of(context).size.height*.02,),

                Text('${widget.serviceModel.price} ${AppLocalizations.of(context)!.translate('saR').toString()}',style: GoogleFonts.almarai(
                    fontWeight: FontWeight.w700,
                    fontSize: MediaQuery.of(context).size.height*.022,
                    color: ColorManager.textColor
                ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: MediaQuery.of(context).size.height*.02,),

                if(widget.index ==0)
                  cubit.homeOrderNumber1 ==0?
                  ButtonWidget(
                      buttonText: AppLocalizations.of(context)!.translate('addToCarT').toString(),
                      buttonColor: ColorManager.white,
                      onTap: (){
                        cubit.insertOrderDatabase(name: '${widget.serviceModel.title}', price: '${widget.serviceModel.price}', rate: 'yes', image: '${widget.serviceModel.image}',address: 'no',context: context);
                        setState(() {
                          cubit.homeOrderNumber1++;
                          CashHelper.saveData(key: 'homeOrder1',value: cubit.homeOrderNumber2);
                        });
                      }
                  ):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height*.2,
                        decoration: BoxDecoration(
                            color: ColorManager.toolbarColor,
                            border: Border.all(color: ColorManager.white),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: Row(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                    setState(() {
                                      cubit.homeOrderNumber1++;
                                      CashHelper.saveData(key: 'homeOrder1',value: cubit.homeOrderNumber1);

                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text('+',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.035,
                                      color: ColorManager.black
                                  ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Text('${cubit.homeOrderNumber1}',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.025,
                                      color: ColorManager.black
                                  ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),

                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if(cubit.homeOrderNumber1>1){
                                      cubit.homeOrderNumber1--;
                                      CashHelper.saveData(key: 'homeOrder1',value: cubit.homeOrderNumber1);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text('-',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.035,
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

                    ],
                  ),

                if(widget.index ==1)
                  cubit.homeOrderNumber2 ==0?
                  ButtonWidget(
                      buttonText: AppLocalizations.of(context)!.translate('addToCarT').toString(),
                      buttonColor: ColorManager.white,
                      onTap: (){
                        cubit.insertOrderDatabase(name: '${widget.serviceModel.title}', price: '${widget.serviceModel.price}', rate: 'yes', image: '${widget.serviceModel.image}',address: 'no',context: context);
                        setState(() {
                          cubit.homeOrderNumber2++;
                          CashHelper.saveData(key: 'homeOrder2',value: cubit.homeOrderNumber2);
                        });
                      }
                  ):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height*.2,
                        decoration: BoxDecoration(
                            color: ColorManager.toolbarColor,
                            border: Border.all(color: ColorManager.white),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: Row(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    setState(() {
                                      cubit.homeOrderNumber2++;
                                      CashHelper.saveData(key: 'homeOrder2',value: cubit.homeOrderNumber2);
                                    });
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text('+',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.035,
                                      color: ColorManager.black
                                  ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Text('${cubit.homeOrderNumber2}',style: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w700,
                                    fontSize: MediaQuery.of(context).size.height*.025,
                                    color: ColorManager.black
                                ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if(cubit.homeOrderNumber2>1){
                                      cubit.homeOrderNumber2--;
                                      CashHelper.saveData(key: 'homeOrder2',value: cubit.homeOrderNumber2);

                                    }
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text('-',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.035,
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

                    ],
                  ),

                if(widget.index ==2)
                  cubit.homeOrderNumber3 ==0?
                  ButtonWidget(
                      buttonText: AppLocalizations.of(context)!.translate('addToCarT').toString(),
                      buttonColor: ColorManager.white,
                      onTap: (){
                        cubit.insertOrderDatabase(name: '${widget.serviceModel.title}', price: '${widget.serviceModel.price}', rate: 'yes', image: '${widget.serviceModel.image}',address: 'no',context: context);
                        setState(() {
                          cubit.homeOrderNumber3++;
                          CashHelper.saveData(key: 'homeOrder3',value: cubit.homeOrderNumber3);
                        });
                      }
                  ):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height*.2,
                        decoration: BoxDecoration(
                            color: ColorManager.toolbarColor,
                            border: Border.all(color: ColorManager.white),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: Row(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                    setState(() {
                                      cubit.homeOrderNumber3++;
                                      CashHelper.saveData(key: 'homeOrder3',value: cubit.homeOrderNumber3);
                                    });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text('+',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.035,
                                      color: ColorManager.black
                                  ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Text('${cubit.homeOrderNumber3}',style: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w700,
                                    fontSize: MediaQuery.of(context).size.height*.025,
                                    color: ColorManager.black
                                ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if(cubit.homeOrderNumber3>1){
                                      cubit.homeOrderNumber3--;
                                      CashHelper.saveData(key: 'homeOrder3',value: cubit.homeOrderNumber3);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text('-',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.035,
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

                    ],
                  ),

                if(widget.index ==3)
                  cubit.homeOrderNumber4 ==0?
                  ButtonWidget(
                      buttonText: AppLocalizations.of(context)!.translate('addToCarT').toString(),
                      buttonColor: ColorManager.white,
                      onTap: (){
                        cubit.insertOrderDatabase(name: '${widget.serviceModel.title}', price: '${widget.serviceModel.price}', rate: 'yes', image: '${widget.serviceModel.image}',address: 'no',context: context);
                        setState(() {
                          cubit.homeOrderNumber4++;
                          CashHelper.saveData(key: 'homeOrder4',value: cubit.homeOrderNumber4);
                        });
                      }
                  ):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height*.2,
                        decoration: BoxDecoration(
                            color: ColorManager.toolbarColor,
                            border: Border.all(color: ColorManager.white),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: Row(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                    setState(() {
                                      cubit.homeOrderNumber4++;
                                      CashHelper.saveData(key: 'homeOrder4',value: cubit.homeOrderNumber4);
                                    });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text('+',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.035,
                                      color: ColorManager.black
                                  ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Text('${cubit.homeOrderNumber4}',style: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w700,
                                    fontSize: MediaQuery.of(context).size.height*.025,
                                    color: ColorManager.black
                                ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if(cubit.homeOrderNumber4>1){
                                      cubit.homeOrderNumber4--;
                                      CashHelper.saveData(key: 'homeOrder4',value: cubit.homeOrderNumber4);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text('-',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.035,
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

                    ],
                  ),


                if(widget.index ==4)
                  cubit.homeOrderNumber5 ==0?
                  ButtonWidget(
                      buttonText: AppLocalizations.of(context)!.translate('addToCarT').toString(),
                      buttonColor: ColorManager.white,
                      onTap: (){
                        cubit.insertOrderDatabase(name: '${widget.serviceModel.title}', price: '${widget.serviceModel.price}', rate: 'yes', image: '${widget.serviceModel.image}',address: 'no',context: context);
                        setState(() {
                          cubit.homeOrderNumber5++;
                          CashHelper.saveData(key: 'homeOrder5',value: cubit.homeOrderNumber5);
                        });
                      }
                  ):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height*.2,
                        decoration: BoxDecoration(
                            color: ColorManager.toolbarColor,
                            border: Border.all(color: ColorManager.white),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: Row(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    cubit.homeOrderNumber5++;
                                    CashHelper.saveData(key: 'homeOrder5',value: cubit.homeOrderNumber5);
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text('+',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.035,
                                      color: ColorManager.black
                                  ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Text('${cubit.homeOrderNumber5}',style: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w700,
                                    fontSize: MediaQuery.of(context).size.height*.025,
                                    color: ColorManager.black
                                ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if(cubit.homeOrderNumber5>1){
                                      cubit.homeOrderNumber5--;
                                      CashHelper.saveData(key: 'homeOrder5',value: cubit.homeOrderNumber5);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text('-',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.035,
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

                    ],
                  ),


                if(widget.index ==5)
                  cubit.homeOrderNumber6 ==0?
                  ButtonWidget(
                      buttonText: AppLocalizations.of(context)!.translate('addToCarT').toString(),
                      buttonColor: ColorManager.white,
                      onTap: (){
                        cubit.insertOrderDatabase(name: '${widget.serviceModel.title}', price: '${widget.serviceModel.price}', rate: 'yes', image: '${widget.serviceModel.image}',address: 'no',context: context);
                        setState(() {
                          cubit.homeOrderNumber6++;
                          CashHelper.saveData(key: 'homeOrder6',value: cubit.homeOrderNumber6);
                        });
                      }
                  ):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height*.2,
                        decoration: BoxDecoration(
                            color: ColorManager.toolbarColor,
                            border: Border.all(color: ColorManager.white),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: Row(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    cubit.homeOrderNumber6++;
                                    CashHelper.saveData(key: 'homeOrder6',value: cubit.homeOrderNumber6);
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text('+',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.035,
                                      color: ColorManager.black
                                  ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Text('${cubit.homeOrderNumber6}',style: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w700,
                                    fontSize: MediaQuery.of(context).size.height*.025,
                                    color: ColorManager.black
                                ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if(cubit.homeOrderNumber6>1){
                                      cubit.homeOrderNumber6--;
                                      CashHelper.saveData(key: 'homeOrder6',value: cubit.homeOrderNumber6);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text('-',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.035,
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

                    ],
                  ),

                if(widget.index ==6)
                  cubit.homeOrderNumber7 ==0?
                  ButtonWidget(
                      buttonText: AppLocalizations.of(context)!.translate('addToCarT').toString(),
                      buttonColor: ColorManager.white,
                      onTap: (){
                        cubit.insertOrderDatabase(name: '${widget.serviceModel.title}', price: '${widget.serviceModel.price}', rate: 'yes', image: '${widget.serviceModel.image}',address: 'no',context: context);
                        setState(() {
                          cubit.homeOrderNumber7++;
                          CashHelper.saveData(key: 'homeOrder7',value: cubit.homeOrderNumber7);
                        });
                      }
                  ):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height*.2,
                        decoration: BoxDecoration(
                            color: ColorManager.toolbarColor,
                            border: Border.all(color: ColorManager.white),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: Row(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    cubit.homeOrderNumber7++;
                                    CashHelper.saveData(key: 'homeOrder7',value: cubit.homeOrderNumber7);
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text('+',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.035,
                                      color: ColorManager.black
                                  ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Text('${cubit.homeOrderNumber7}',style: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w700,
                                    fontSize: MediaQuery.of(context).size.height*.025,
                                    color: ColorManager.black
                                ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if(cubit.homeOrderNumber7>1){
                                      cubit.homeOrderNumber7--;
                                      CashHelper.saveData(key: 'homeOrder7',value: cubit.homeOrderNumber7);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text('-',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.035,
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

                    ],
                  ),

                if(widget.index ==7)
                  cubit.homeOrderNumber8 ==0?
                  ButtonWidget(
                      buttonText: AppLocalizations.of(context)!.translate('addToCarT').toString(),
                      buttonColor: ColorManager.white,
                      onTap: (){
                        cubit.insertOrderDatabase(name: '${widget.serviceModel.title}', price: '${widget.serviceModel.price}', rate: 'yes', image: '${widget.serviceModel.image}',address: 'no',context: context);
                        setState(() {
                          cubit.homeOrderNumber8++;
                          CashHelper.saveData(key: 'homeOrder8',value: cubit.homeOrderNumber8);
                        });
                      }
                  ):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height*.2,
                        decoration: BoxDecoration(
                            color: ColorManager.toolbarColor,
                            border: Border.all(color: ColorManager.white),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: Row(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    cubit.homeOrderNumber8++;
                                    CashHelper.saveData(key: 'homeOrder8',value: cubit.homeOrderNumber8);
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text('+',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.035,
                                      color: ColorManager.black
                                  ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Text('${cubit.homeOrderNumber8}',style: GoogleFonts.almarai(
                                    fontWeight: FontWeight.w700,
                                    fontSize: MediaQuery.of(context).size.height*.025,
                                    color: ColorManager.black
                                ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if(cubit.homeOrderNumber8>1){
                                      cubit.homeOrderNumber8--;
                                      CashHelper.saveData(key: 'homeOrder8',value: cubit.homeOrderNumber8);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text('-',style: GoogleFonts.almarai(
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height*.035,
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

                    ],
                  ),

              ],
            ),

          ) :
          CircularProgressIndicator(
            color: ColorManager.primaryColor,
          );
      },
    );
  }
}
