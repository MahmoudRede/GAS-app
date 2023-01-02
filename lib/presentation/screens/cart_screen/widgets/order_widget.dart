import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:gas/business_logic/app_cubit/app_cubit.dart';
import 'package:gas/business_logic/app_cubit/app_states.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/style/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderWidget extends StatefulWidget {
  final int index;
  const OrderWidget({Key? key,required this.index}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {

  @override
  void initState() {
    super.initState();




  }


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
          child: SwipeActionCell(
              backgroundColor: Colors.transparent,
              key: ObjectKey(cubit.allSelected[widget.index]),
              trailingActions: <SwipeAction>[
                SwipeAction(
                    icon: Icon(
                      Icons.delete,
                      color: ColorManager.white,
                      size: MediaQuery.of(context).size.height*.042,
                    ),
                    style: GoogleFonts.almarai(
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height*.022,
                        color: ColorManager.white
                    ),
                    onTap: (CompletionHandler handler) async {
                      cubit.deleteOrderDatabase(name: cubit.allSelected[widget.index]['name'],context: context);

                    },
                    backgroundRadius: 7,
                    color: Colors.red
                ),

              ],
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
                        image:  NetworkImage(cubit.allSelected[widget.index]['image']),
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

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: GestureDetector(
                                onTap: (){
                                  cubit.deleteOrderDatabase(name: cubit.allSelected[widget.index]['name'],context: context);
                                },
                                child: CircleAvatar(
                                  backgroundColor: ColorManager.red,
                                  radius: 15,
                                  child:Icon(
                                    Icons.delete,
                                    color: ColorManager.white,
                                    size: MediaQuery.of(context).size.height*.03,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.height*.015,),

                                    Text(cubit.allSelected[widget.index]['name'],style: GoogleFonts.almarai(
                                        fontWeight: FontWeight.w300,
                                        fontSize: MediaQuery.of(context).size.height*.022,
                                        color: ColorManager.textColor
                                    ),
                                      textAlign: TextAlign.center,
                                    ),

                                    SizedBox(height: MediaQuery.of(context).size.height*.02,),

                                    Text('${cubit.allSelected[widget.index]['price']} ${AppLocalizations.of(context)!.translate('saR').toString()}',style: GoogleFonts.almarai(
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
                                            cubit.increaseValue(index: widget.index);
                                            if(widget.index==0){
                                              cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers0}' ).then((value) {

                                              });

                                            }

                                            if(widget.index==1){

                                              cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers1}' );
                                              cubit.totalPrice=cubit.totalPrice+ int.parse(cubit.allSelected[widget.index]['price']);

                                            }

                                            if(widget.index==2){

                                              cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers2}' );
                                              cubit.totalPrice=cubit.totalPrice+ int.parse(cubit.allSelected[widget.index]['price']);

                                            }

                                            if(widget.index==3){

                                              cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers3}' );
                                              cubit.totalPrice=cubit.totalPrice+ int.parse(cubit.allSelected[widget.index]['price']);

                                            }

                                            if(widget.index==4){

                                              cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers4}' );
                                              cubit.totalPrice=cubit.totalPrice+ int.parse(cubit.allSelected[widget.index]['price']);

                                            }

                                            if(widget.index==5){

                                              cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers5}' );
                                              cubit.totalPrice=cubit.totalPrice+ int.parse(cubit.allSelected[widget.index]['price']);

                                            }

                                            if(widget.index==6){

                                              cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers6}' );
                                              cubit.totalPrice=cubit.totalPrice+ int.parse(cubit.allSelected[widget.index]['price']);

                                            }

                                            if(widget.index==7){

                                              cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers7}' );
                                              cubit.totalPrice=cubit.totalPrice+ int.parse(cubit.allSelected[widget.index]['price']);

                                            }

                                            if(widget.index==8){

                                              cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers8}' );
                                              cubit.totalPrice=cubit.totalPrice+ int.parse(cubit.allSelected[widget.index]['price']);

                                            }

                                            if(widget.index==9){

                                              cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers9}' );
                                              cubit.totalPrice=cubit.totalPrice+ int.parse(cubit.allSelected[widget.index]['price']);

                                            }

                                            if(widget.index==10){

                                              cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers10}' );
                                              cubit.totalPrice=cubit.totalPrice+ int.parse(cubit.allSelected[widget.index]['price']);

                                            }

                                            if(widget.index==11){

                                              cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers11}' );
                                              cubit.totalPrice=cubit.totalPrice+ int.parse(cubit.allSelected[widget.index]['price']);

                                            }

                                            if(widget.index==12){

                                              cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers12}' );
                                              cubit.totalPrice=cubit.totalPrice+ int.parse(cubit.allSelected[widget.index]['price']);

                                            }
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

                                    if(widget.index==0)
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Text('${cubit.orderNumbers0}',style: GoogleFonts.almarai(
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context).size.height*.025,
                                              color: ColorManager.black
                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),

                                    if(widget.index==1)
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Text('${cubit.orderNumbers1}',style: GoogleFonts.almarai(
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context).size.height*.025,
                                              color: ColorManager.black
                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),

                                    if(widget.index==2)
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Text('${cubit.orderNumbers2}',style: GoogleFonts.almarai(
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context).size.height*.025,
                                              color: ColorManager.black
                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),

                                    if(widget.index==3)
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Text('${cubit.orderNumbers3}',style: GoogleFonts.almarai(
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context).size.height*.025,
                                              color: ColorManager.black
                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),

                                    if(widget.index==4)
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Text('${cubit.orderNumbers4}',style: GoogleFonts.almarai(
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context).size.height*.025,
                                              color: ColorManager.black
                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),

                                    if(widget.index==5)
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Text('${cubit.orderNumbers5}',style: GoogleFonts.almarai(
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context).size.height*.025,
                                              color: ColorManager.black
                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),

                                    if(widget.index==6)
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Text('${cubit.orderNumbers6}',style: GoogleFonts.almarai(
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context).size.height*.025,
                                              color: ColorManager.black
                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),

                                    if(widget.index==7)
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Text('${cubit.orderNumbers7}',style: GoogleFonts.almarai(
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context).size.height*.025,
                                              color: ColorManager.black
                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),

                                    if(widget.index==8)
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Text('${cubit.orderNumbers8}',style: GoogleFonts.almarai(
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context).size.height*.025,
                                              color: ColorManager.black
                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),

                                    if(widget.index==9)
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Text('${cubit.orderNumbers9}',style: GoogleFonts.almarai(
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context).size.height*.025,
                                              color: ColorManager.black
                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),

                                    if(widget.index==10)
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Text('${cubit.orderNumbers10}',style: GoogleFonts.almarai(
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context).size.height*.025,
                                              color: ColorManager.black
                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),

                                    if(widget.index==11)
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Text('${cubit.orderNumbers11}',style: GoogleFonts.almarai(
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context).size.height*.025,
                                              color: ColorManager.black
                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),

                                    if(widget.index==12)
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(MediaQuery.of(context).size.height*.015),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Text('${cubit.orderNumbers12}',style: GoogleFonts.almarai(
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
                                            cubit.decreaseValue(index: widget.index);
                                            if(widget.index==0){

                                              if(cubit.orderNumbers0>1){
                                                cubit.totalPrice=cubit.totalPrice- int.parse(cubit.allSelected[widget.index]['price']);
                                              }
                                              if(cubit.orderNumbers0>0){
                                                cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers0}' );
                                              }

                                            }

                                            if(widget.index==1){

                                              if(cubit.orderNumbers1>1){
                                                cubit.totalPrice=cubit.totalPrice- int.parse(cubit.allSelected[widget.index]['price']);
                                              }
                                              if(cubit.orderNumbers1>0){
                                                cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers1}' );
                                              }
                                            }

                                            if(widget.index==2){

                                              if(cubit.orderNumbers2>1){
                                                cubit.totalPrice=cubit.totalPrice- int.parse(cubit.allSelected[widget.index]['price']);
                                              }
                                              if(cubit.orderNumbers2>0){
                                                cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers2}' );
                                              }
                                            }

                                            if(widget.index==3){

                                              if(cubit.orderNumbers3>1){
                                                cubit.totalPrice=cubit.totalPrice- int.parse(cubit.allSelected[widget.index]['price']);
                                              }
                                              if(cubit.orderNumbers3>0){
                                                cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers3}' );
                                              }
                                            }

                                            if(widget.index==4){

                                              if(cubit.orderNumbers4>1){
                                                cubit.totalPrice=cubit.totalPrice- int.parse(cubit.allSelected[widget.index]['price']);
                                              }
                                              if(cubit.orderNumbers4>0){
                                                cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers4}' );
                                              }
                                            }

                                            if(widget.index==5){

                                              if(cubit.orderNumbers5>1){
                                                cubit.totalPrice=cubit.totalPrice- int.parse(cubit.allSelected[widget.index]['price']);
                                              }
                                              if(cubit.orderNumbers5>0){
                                                cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers5}' );
                                              }
                                            }

                                            if(widget.index==6){

                                              if(cubit.orderNumbers6>1){
                                                cubit.totalPrice=cubit.totalPrice- int.parse(cubit.allSelected[widget.index]['price']);
                                              }
                                              if(cubit.orderNumbers6>0){
                                                cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers6}' );
                                              }
                                            }

                                            if(widget.index==7){

                                              if(cubit.orderNumbers7>1){
                                                cubit.totalPrice=cubit.totalPrice- int.parse(cubit.allSelected[widget.index]['price']);
                                              }
                                              if(cubit.orderNumbers7>0){
                                                cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers7}' );
                                              }
                                            }

                                            if(widget.index==8){

                                              if(cubit.orderNumbers8>1){
                                                cubit.totalPrice=cubit.totalPrice- int.parse(cubit.allSelected[widget.index]['price']);
                                              }
                                              if(cubit.orderNumbers8>0){
                                                cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers8}' );
                                              }
                                            }

                                            if(widget.index==9){

                                              if(cubit.orderNumbers9>1){
                                                cubit.totalPrice=cubit.totalPrice- int.parse(cubit.allSelected[widget.index]['price']);
                                              }
                                              if(cubit.orderNumbers9>0){
                                                cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers9}' );
                                              }
                                            }

                                            if(widget.index==10){

                                              if(cubit.orderNumbers10>1){
                                                cubit.totalPrice=cubit.totalPrice- int.parse(cubit.allSelected[widget.index]['price']);
                                              }
                                              if(cubit.orderNumbers10>0){
                                                cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers10}' );
                                              }
                                            }

                                            if(widget.index==11){

                                              if(cubit.orderNumbers11>1){
                                                cubit.totalPrice=cubit.totalPrice- int.parse(cubit.allSelected[widget.index]['price']);
                                              }
                                              if(cubit.orderNumbers11>0){
                                                cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers11}' );
                                              }
                                            }

                                            if(widget.index==12){

                                              if(cubit.orderNumbers12>1){
                                                cubit.totalPrice=cubit.totalPrice- int.parse(cubit.allSelected[widget.index]['price']);
                                              }
                                              if(cubit.orderNumbers12>0){
                                                cubit.updateOrderDatabase(name: cubit.allSelected[widget.index]['name'],newNumber:'${cubit.orderNumbers12}' );
                                              }
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
                    ),

                  ],
                ),
              )
          ),
        );
      },
    );
  }
}
