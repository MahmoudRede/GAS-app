import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gas/business_logic/app_cubit/app_cubit.dart';
import 'package:gas/business_logic/app_cubit/app_states.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/presentation/screens/cart_screen/screen/cart_screen.dart';
import 'package:gas/presentation/screens/home_screen/widgets/service_widget.dart';
import 'package:gas/style/app_color.dart';
import 'package:gas/utils/local/cash_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool i=false;

  @override
  void initState() {
    super.initState();

    if(CashHelper.getData(key: 'homeOrder1')!=null&&CashHelper.getData(key: 'homeOrder1')!=0){
      AppCubit.get(context).homeOrderNumber1=CashHelper.getData(key: 'homeOrder1');
    }

    if(CashHelper.getData(key: 'homeOrder2')!=null&&CashHelper.getData(key: 'homeOrder2')!=0){
      AppCubit.get(context).homeOrderNumber2=CashHelper.getData(key: 'homeOrder2');
    }

    if(CashHelper.getData(key: 'homeOrder3')!=null&&CashHelper.getData(key: 'homeOrder3')!=0){
      AppCubit.get(context).homeOrderNumber3=CashHelper.getData(key: 'homeOrder3');
    }

    if(CashHelper.getData(key: 'homeOrder4')!=null&&CashHelper.getData(key: 'homeOrder4')!=0){
      AppCubit.get(context).homeOrderNumber4=CashHelper.getData(key: 'homeOrder4');
    }

    if(CashHelper.getData(key: 'homeOrder5')!=null&&CashHelper.getData(key: 'homeOrder5')!=0){
      AppCubit.get(context).homeOrderNumber5=CashHelper.getData(key: 'homeOrder5');
    }

    if(CashHelper.getData(key: 'homeOrder6')!=null&&CashHelper.getData(key: 'homeOrder6')!=0){
      AppCubit.get(context).homeOrderNumber6=CashHelper.getData(key: 'homeOrder6');
    }

    if(CashHelper.getData(key: 'homeOrder7')!=null&&CashHelper.getData(key: 'homeOrder7')!=0){
      AppCubit.get(context).homeOrderNumber7=CashHelper.getData(key: 'homeOrder7');
    }

    if(CashHelper.getData(key: 'homeOrder8')!=null&&CashHelper.getData(key: 'homeOrder8')!=0){
      AppCubit.get(context).homeOrderNumber8=CashHelper.getData(key: 'homeOrder8');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=AppCubit.get(context);
        return Scaffold(
          body: CustomScrollView(

            slivers:<Widget> [

              // AppBar
              SliverAppBar(

                leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),

                // cart icon
                actions:  [
                  GestureDetector(
                     onTap: (){

                       if(AppCubit.get(context).allSelected.length>=1){
                         if(AppCubit.get(context).allSelected[0]['name']=='أسطوانة غاز جديدة'){

                           print('Here 1');
                           print(AppCubit.get(context).homeOrderNumber1);
                           print(AppCubit.get(context).homeOrderNumber2);
                           AppCubit.get(context).orderNumbers0=AppCubit.get(context).homeOrderNumber2;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[0]['name'],newNumber:'${AppCubit.get(context).orderNumbers0}' );


                         }

                         else if(AppCubit.get(context).allSelected[0]['name']=='أنبوب غاز مرن طول متر'){
                           print('Here 2');
                           print(AppCubit.get(context).homeOrderNumber1);
                           print(AppCubit.get(context).homeOrderNumber2);
                           AppCubit.get(context).orderNumbers0=AppCubit.get(context).homeOrderNumber1;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[0]['name'],newNumber:'${AppCubit.get(context).orderNumbers0}' );
                         }

                         else if(AppCubit.get(context).allSelected[0]['name']=='تعبئة أسطوانة غاز'){
                           print('Here 3');

                           AppCubit.get(context).orderNumbers0=AppCubit.get(context).homeOrderNumber3;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[0]['name'],newNumber:'${AppCubit.get(context).orderNumbers0}' );
                         }

                         else if(AppCubit.get(context).allSelected[0]['name']=='منظم غاز'){
                           print('Here 4');

                           print(AppCubit.get(context).homeOrderNumber4);
                           AppCubit.get(context).orderNumbers0=AppCubit.get(context).homeOrderNumber4;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[0]['name'],newNumber:'${AppCubit.get(context).orderNumbers0}' );
                         }

                         else{

                           AppCubit.get(context).orderNumbers0=AppCubit.get(context).homeOrderNumber5;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[0]['name'],newNumber:'${AppCubit.get(context).orderNumbers0}' );
                         }
                       }


                       if(AppCubit.get(context).allSelected.length>=2){

                         if(AppCubit.get(context).allSelected[1]['name']=='أسطوانة غاز جديدة'){


                           AppCubit.get(context).orderNumbers1=AppCubit.get(context).homeOrderNumber2;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[0]['name'],newNumber:'${AppCubit.get(context).orderNumbers1}' );


                         }

                         else if(AppCubit.get(context).allSelected[1]['name']=='أنبوب غاز مرن طول متر'){

                           AppCubit.get(context).orderNumbers1=AppCubit.get(context).homeOrderNumber1;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[1]['name'],newNumber:'${AppCubit.get(context).orderNumbers1}' );
                         }

                         else if(AppCubit.get(context).allSelected[1]['name']=='تعبئة أسطوانة غاز'){
                           print('Here 3');

                           AppCubit.get(context).orderNumbers1=AppCubit.get(context).homeOrderNumber3;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[1]['name'],newNumber:'${AppCubit.get(context).orderNumbers1}' );
                         }

                         else if(AppCubit.get(context).allSelected[1]['name']=='منظم غاز'){
                           print('Here 4');

                           print(AppCubit.get(context).homeOrderNumber4);
                           AppCubit.get(context).orderNumbers1=AppCubit.get(context).homeOrderNumber4;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[1]['name'],newNumber:'${AppCubit.get(context).orderNumbers1}' );
                         }

                         else{
                           print('Here 4');

                           AppCubit.get(context).orderNumbers1=AppCubit.get(context).homeOrderNumber5;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[1]['name'],newNumber:'${AppCubit.get(context).orderNumbers1}' );
                         }
                       }

                       if(AppCubit.get(context).allSelected.length>=3){

                         if(AppCubit.get(context).allSelected[2]['name']=='أسطوانة غاز جديدة'){


                           AppCubit.get(context).orderNumbers2=AppCubit.get(context).homeOrderNumber2;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[1]['name'],newNumber:'${AppCubit.get(context).orderNumbers2}' );


                         }

                         else if(AppCubit.get(context).allSelected[2]['name']=='أنبوب غاز مرن طول متر'){

                           AppCubit.get(context).orderNumbers2=AppCubit.get(context).homeOrderNumber1;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[2]['name'],newNumber:'${AppCubit.get(context).orderNumbers2}' );
                         }

                         else if(AppCubit.get(context).allSelected[2]['name']=='تعبئة أسطوانة غاز'){
                           print('Here 3');

                           AppCubit.get(context).orderNumbers2=AppCubit.get(context).homeOrderNumber3;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[2]['name'],newNumber:'${AppCubit.get(context).orderNumbers2}' );
                         }

                         else if(AppCubit.get(context).allSelected[2]['name']=='منظم غاز'){
                           print('Here 4');

                           AppCubit.get(context).orderNumbers2=AppCubit.get(context).homeOrderNumber4;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[2]['name'],newNumber:'${AppCubit.get(context).orderNumbers2}' );
                         }

                         else{
                           print('Here 4');

                           AppCubit.get(context).orderNumbers2=AppCubit.get(context).homeOrderNumber5;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[2]['name'],newNumber:'${AppCubit.get(context).orderNumbers2}' );
                         }

                       }


                       if(AppCubit.get(context).allSelected.length>=4){
                         if(AppCubit.get(context).allSelected[3]['name']=='أسطوانة غاز جديدة'){

                           AppCubit.get(context).orderNumbers3=AppCubit.get(context).homeOrderNumber2;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[3]['name'],newNumber:'${AppCubit.get(context).orderNumbers3}' );

                         }

                         else if(AppCubit.get(context).allSelected[3]['name']=='أنبوب غاز مرن طول متر'){

                           AppCubit.get(context).orderNumbers3=AppCubit.get(context).homeOrderNumber1;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[3]['name'],newNumber:'${AppCubit.get(context).orderNumbers3}' );
                         }

                         else if(AppCubit.get(context).allSelected[3]['name']=='تعبئة أسطوانة غاز'){
                           print('Here 3');

                           AppCubit.get(context).orderNumbers3=AppCubit.get(context).homeOrderNumber3;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[3]['name'],newNumber:'${AppCubit.get(context).orderNumbers3}' );
                         }

                         else if(AppCubit.get(context).allSelected[3]['name']=='منظم غاز'){
                           print('Here 4');

                           print(AppCubit.get(context).homeOrderNumber4);
                           AppCubit.get(context).orderNumbers3=AppCubit.get(context).homeOrderNumber4;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[3]['name'],newNumber:'${AppCubit.get(context).orderNumbers3}' );
                         }

                         else{
                           print('Here 4');

                           AppCubit.get(context).orderNumbers3=AppCubit.get(context).homeOrderNumber5;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[3]['name'],newNumber:'${AppCubit.get(context).orderNumbers3}' );
                         }
                       }

                       if(AppCubit.get(context).allSelected.length>=5){
                         if(AppCubit.get(context).allSelected[4]['name']=='أسطوانة غاز جديدة'){

                           AppCubit.get(context).orderNumbers4=AppCubit.get(context).homeOrderNumber2;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[4]['name'],newNumber:'${AppCubit.get(context).orderNumbers4}' );

                         }

                         else if(AppCubit.get(context).allSelected[4]['name']=='أنبوب غاز مرن طول متر'){

                           AppCubit.get(context).orderNumbers4=AppCubit.get(context).homeOrderNumber1;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[4]['name'],newNumber:'${AppCubit.get(context).orderNumbers4}' );
                         }

                         else if(AppCubit.get(context).allSelected[4]['name']=='تعبئة أسطوانة غاز'){
                           print('Here 3');

                           AppCubit.get(context).orderNumbers4=AppCubit.get(context).homeOrderNumber3;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[4]['name'],newNumber:'${AppCubit.get(context).orderNumbers4}' );
                         }

                         else if(AppCubit.get(context).allSelected[4]['name']=='منظم غاز'){
                           print('Here 4');

                           AppCubit.get(context).orderNumbers4=AppCubit.get(context).homeOrderNumber4;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[4]['name'],newNumber:'${AppCubit.get(context).orderNumbers4}' );
                         }

                         else{
                           print('Here 4');

                           AppCubit.get(context).orderNumbers4=AppCubit.get(context).homeOrderNumber5;
                           AppCubit.get(context).updateOrderDatabase(name: AppCubit.get(context).allSelected[4]['name'],newNumber:'${AppCubit.get(context).orderNumbers4}' );
                         }
                       }

                       Navigator.push(context, MaterialPageRoute(builder: (_){
                         return const CartScreen();
                       }));
                     },
                     child: Image(
                       image: const AssetImage('assets/images/cart.png'),
                       height: MediaQuery.of(context).size.height*.01,
                       width: MediaQuery.of(context).size.height*.055,
                     ),
                   ),
                  SizedBox(width: MediaQuery.of(context).size.height*.018,),
                ],


                pinned: cubit.pinned,
                snap: cubit.snap,
                floating: cubit.floating,
                expandedHeight: MediaQuery.of(context).size.height*.34,

                // title and image
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'splash',
                    child: Image(
                      image: const AssetImage('assets/images/small_gas.png'),
                      height: MediaQuery.of(context).size.height*.015,
                      width: MediaQuery.of(context).size.height*.1,
                    ),
                  ),
                  titlePadding: EdgeInsets.zero,
                  centerTitle: true,
                  title: ListView(
                    reverse: true,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.012,),

                      Text('أنت أطلب و إحنا نوصل',style: GoogleFonts.almarai(
                          fontWeight: FontWeight.w300,
                          fontSize: MediaQuery.of(context).size.height*.018,
                          color: ColorManager.black),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*.007,),

                      Text(AppLocalizations.of(context)!.translate('appName').toString(),style: GoogleFonts.almarai(
                          fontWeight: FontWeight.w700,
                          fontSize: MediaQuery.of(context).size.height*.022,
                          color: ColorManager.black),
                        textAlign: TextAlign.center,
                      ),

                    ],
                  ),
                ),
              ),

              // Body


              SliverToBoxAdapter(
                child:cubit.services.isNotEmpty? Column(
                  children: [
                    GridView.count(
                      shrinkWrap:true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1/1.6,
                      mainAxisSpacing: MediaQuery.of(context).size.height*.01,
                      crossAxisCount: 2,
                      children: List.generate(cubit.services.length, (index) => ServiceWidget(serviceModel: cubit.services[index],index: index,)
                      ),

                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*.02,),


                  ],
                ) :
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*.05,),
                    CircularProgressIndicator(
                      color: ColorManager.primaryColor,
                    ),
                  ],
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
