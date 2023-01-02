import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gas/business_logic/app_cubit/app_states.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/data/models/driver_model.dart';
import 'package:gas/data/models/order_model.dart';
import 'package:gas/data/models/service_model.dart';
import 'package:gas/data/models/user_model.dart';
import 'package:gas/presentation/screens/driver_screen/screen/view_order_screen.dart';
import 'package:gas/presentation/screens/driver_screen/widget/view_order_widget.dart';
import 'package:gas/presentation/screens/home_screen/screen/home_screen.dart';
import 'package:gas/presentation/screens/start_screen/screen/start_screen.dart';
import 'package:gas/presentation/widgets/toast.dart';
import 'package:gas/style/app_color.dart';
import 'package:gas/utils/local/cash_helper.dart';
import 'package:gas/utils/local/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCubit extends Cubit<AppStates>{


  AppCubit() : super(InitialState());

  static AppCubit get(context)=> BlocProvider.of(context);

  bool pinned = true;
  bool snap = true;
  bool floating = true;

  List<ServiceModel> services=[] ;


  int homeOrderNumber1=0;
  int homeOrderNumber2=0;
  int homeOrderNumber3=0;
  int homeOrderNumber4=0;
  int homeOrderNumber5=0;
  int homeOrderNumber6=0;
  int homeOrderNumber7=0;
  int homeOrderNumber8=0;

  // get Services
  Future<void> getService()async{

    emit(GetServicesLoadingState());
    FirebaseFirestore.instance
        .collection('services')
        .get().then((value) {
         services=[];

          for (var element in value.docs) {
            services.add(ServiceModel.fromFire(element.data()));
          }
          debugPrint('Get All Success');
          emit(GetServicesSuccessState());

    }).catchError((error){

      debugPrint('Error in get services is ${error.toString()}');
      emit(GetServicesErrorState());

    });

  }

  List isBool= List.generate(100, (index) => false);

  void changeFavoriteColorToTrue({required String name}){


    CashHelper.saveData(key: '$name',value:true );
    debugPrint('Item favorite updated To true');
    emit(ChangeFavoriteColorState());

  }

  void changeFavoriteColorToFalse({required String  name}){


    CashHelper.saveData(key: '$name',value:false );
    debugPrint('Item favorite updated to false');
    emit(ChangeFavoriteColorState());

  }

  bool isFavorite=false;

  void switchBetweenOrderAndFavorite(){

    isFavorite=!isFavorite;
    emit(SwitchOrderAndFavoriteState());
  }

  bool isOrder=false;

  void switchBetweenOrderAndMyOrders(){

    isOrder=!isOrder;
    emit(SwitchOrderAndFavoriteState());
  }

  void additionalChangeColor({required int index}){

    isBool[index]= !isBool[index];
    emit(ChangeFavoriteColorState());
  }



  Database ?database;
  Database ?database2;
  List <Map>  allFavorite=[];
  List <Map>  allSelected=[];


  void createDatabase() async {

    return await openDatabase(
        'favorite.db',
        version: 1,
        onCreate: (database,version){
          database.execute(
              'CREATE TABLE favorite (id INTEGER PRIMARY KEY , name TEXT , address TEXT, price TEXT, rate TEXT, image TEXT, favorite TEXT)'
          ).then((value) {
            print('Table Created');
            emit(CreateTableState());
          });
        },
        onOpen: (database){

          getDatabase(database).then((value){
            allFavorite=value;
          }).catchError((error){
            print('error i ${error.toString()}');
          });
          print('Database Opened');
        }

    ).then((value) {
      database=value;
      print('Database Created');
      emit(CreateDatabaseSuccessState());
    }).catchError((error){
      print('error is ${error.toString()}');
      emit(CreateDatabaseErrorState());

    });
  }

  Future insertDatabase(
      {
        required String name,
        required String address,
        required String price,
        required String rate,
        required String image,
        required context,
      }) async{

    return database?.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO favorite (name,address,price,rate,image,favorite) VALUES ( "${name}" , "${address}" , "${price}" , "${rate}" , "${image}" , "yes")'
      ).then((value) {
        print("${value} Insert Success");
        emit(InsertDatabaseSuccessState());
        getDatabase(database).then((value){
          allFavorite=value;
        });
        getService();
        customToast(title: AppLocalizations.of(context)!.translate('addToFavoriteToast').toString(), color: ColorManager.red);
        emit(InsertDatabaseSuccessState());

      }).catchError((error){
        print('Error is ${error.toString()}');
      });

    });

  }


  Future <List<Map>> getDatabase(database)async {

    allFavorite=[];


    return await database?.rawQuery(
        'SELECT * FROM favorite'
    ).then((value) {

      value.forEach((element){




        if(element['address']=='yes')
        {
          print('Here');
          allFavorite.add(element);

        }


      });

      print(allFavorite);
      emit(GetDatabaseSuccessState());
    }).catchError((error){
      print('GetError is ${error.toString()}');
    });
  }


  Future deleteDatabase({required String name,required context})async{

    return await database?.rawDelete('DELETE FROM favorite WHERE name = ?', [name]).then((value) {
      debugPrint('Item Deleted');
      customToast(title:AppLocalizations.of(context)!.translate('deleteToFavoriteToast').toString(), color: ColorManager.red);
      getDatabase(database).then((value) {
        allFavorite=value;
      });
      getService();
      emit(DeleteDatabaseSuccessState());
    });

  }



  void createOrderDatabase() async {

    return await openDatabase(
        'test.db',
        version: 1,
        onCreate: (database,version){
          database.execute(
              'CREATE TABLE test (id INTEGER PRIMARY KEY , name TEXT , address TEXT, price TEXT, rate TEXT, image TEXT, favorite TEXT)'
          ).then((value) {
            print('Table Created');
            emit(CreateTableState());
          });
        },
        onOpen: (database){

          getOrderDatabase(database).then((value){
            allSelected=value;
          }).catchError((error){
            print('error i ${error.toString()}');
          });
          print('Database Opened');
        }

    ).then((value) {
      database2=value;
      print('Database Created');
      emit(CreateDatabaseSuccessState());
    }).catchError((error){
      print('error is ${error.toString()}');
      emit(CreateDatabaseErrorState());

    });
  }


  int orderNumbers0=1;
  int orderNumbers1=1;
  int orderNumbers2=1;
  int orderNumbers3=1;
  int orderNumbers4=1;
  int orderNumbers5=1;
  int orderNumbers6=1;
  int orderNumbers7=1;
  int orderNumbers8=1;
  int orderNumbers9=1;
  int orderNumbers10=1;
  int orderNumbers11=1;
  int orderNumbers12=1;

  int testNumber=1;

  void increaseValue({required int index}){

    if(index==0){
      orderNumbers0++;
    }else if(index==1){
      orderNumbers1++;
    }else if(index==2){
      orderNumbers2++;
    }else if(index==3){
      orderNumbers3++;
    }else if(index==4){
      orderNumbers4++;
    }else if(index==5){
      orderNumbers5++;
    }else if(index==6){
      orderNumbers6++;
    }else if(index==7){
      orderNumbers7++;
    }else if(index==8){
      orderNumbers8++;
    }else if(index==9){
      orderNumbers9++;
    }else if(index==10){
      orderNumbers10++;
    }else if(index==11){
      orderNumbers11++;
    }else if(index==12){
      orderNumbers12++;
    }

    emit(IncreaseValueState());

  }

  void decreaseValue({required int index}){

    if(index==0){
      if(orderNumbers0>1){
        orderNumbers0--;
      }
    }else if(index==1){
      if(orderNumbers1>1){
        orderNumbers1--;
      }
    }else if(index==2){
      if(orderNumbers2>1){
        orderNumbers2--;
      }
    }else if(index==3){
      if(orderNumbers3>1){
        orderNumbers3--;
      }
    }else if(index==4){
      if(orderNumbers4>1){
        orderNumbers4--;
      }
    }else if(index==5){
      if(orderNumbers5>1){
        orderNumbers5--;
      }
    }else if(index==6){
      if(orderNumbers6>1){
        orderNumbers6--;
      }
    }else if(index==7){
      if(orderNumbers7>1){
        orderNumbers7--;
      }
    }else if(index==8){
      if(orderNumbers8>1){
        orderNumbers8--;
      }
    }else if(index==9){
      if(orderNumbers9>1){
        orderNumbers9--;
      }
    }else if(index==10){
      if(orderNumbers10>1){
        orderNumbers10--;
      }
    }else if(index==11){
      if(orderNumbers11>1){
        orderNumbers11--;
      }
    }else if(index==12){
      if(orderNumbers12>1){
        orderNumbers12--;
      }
    }

    emit(DecreaseValueState());


  }

  Future insertOrderDatabase(
      {
        required String name,
        required String address,
        required String price,
        required String rate,
        required String image,
        required context,
      }) async{

    return database2?.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO test (name,address,price,rate,image,favorite) VALUES ( "${name}" , "${address}" , "${price}" , "${rate}" , "${image}" , "${1}")'
      ).then((value) {
        print("${value} Insert Success");
        emit(InsertDatabaseSuccessState());
        getOrderDatabase(database2).then((value){
          allSelected=value;
        });
        getService();
        customToast(title: AppLocalizations.of(context)!.translate('addToCartToast').toString(), color: ColorManager.red);
        emit(InsertDatabaseSuccessState());

      }).catchError((error){
        print('Error is ${error.toString()}');
      });

    });

  }


  int totalPrice=0;

  Future <List<Map>> getOrderDatabase(database)async {

    allSelected=[];
    totalPrice=0;

    return await database?.rawQuery(
        'SELECT * FROM test'
    ).then((value) {
      allSelected=[];

      value.forEach((element){


        if(element['rate']=='yes')
        {
          print('Here');
          allSelected.add(element);

        }
        totalPrice=0;
        allSelected.forEach((element) {
          totalPrice+=(int.parse((element['price']))*int.parse((element['favorite'])));
        });


      });

      print(allFavorite);
      emit(GetDatabaseSuccessState());
    }).catchError((error){
      print('GetError is ${error.toString()}');
    });
  }

  Future <List<Map>> getDeleteOrderDatabase(database)async {

    allSelected=[];
    totalPrice=0;

    return await database?.rawQuery(
        'SELECT * FROM test'
    ).then((value) {
      allSelected=[];

      value.forEach((element){


        if(element['rate']=='yes')
        {
          print('Here');
          allSelected.add(element);

        }
        totalPrice=0;
        allSelected.forEach((element) {
          totalPrice+=(int.parse((element['price']))*1);
        });


      });

      print(allFavorite);
      emit(GetDatabaseSuccessState());
    }).catchError((error){
      print('GetError is ${error.toString()}');
    });
  }



  Future deleteOrderDatabase({required String name,required context})async{

    return await database2?.rawDelete('DELETE FROM test WHERE name = ?', [name]).then((value) {
      debugPrint('Item Deleted');
      customToast(title: AppLocalizations.of(context)!.translate('deleteToCartToast').toString(), color: ColorManager.red);

      orderNumbers0=1;
      orderNumbers1=1;
      orderNumbers2=1;
      orderNumbers3=1;
      orderNumbers4=1;
      orderNumbers5=1;
      orderNumbers6=1;
      orderNumbers7=1;
      orderNumbers8=1;
      orderNumbers9=1;
      orderNumbers10=1;
      orderNumbers11=1;
      orderNumbers12=1;


      if(homeOrderNumber5 !=0){
          homeOrderNumber5;
          CashHelper.saveData(key: 'homeOrder5',value: homeOrderNumber5);
        }

      if(homeOrderNumber1 !=0){
        if(name=='أنبوب غاز مرن طول متر'){
          homeOrderNumber1=0;
          CashHelper.saveData(key: 'homeOrder1',value: homeOrderNumber1);
        }else{
          homeOrderNumber1=1;
          CashHelper.saveData(key: 'homeOrder1',value: homeOrderNumber1);
        }

      }
      if(homeOrderNumber2 !=0){
        if(name=='أسطوانة غاز جديدة'){
          homeOrderNumber2=0;
          CashHelper.saveData(key: 'homeOrder2',value: homeOrderNumber2);
        }else{
          homeOrderNumber2=1;
          CashHelper.saveData(key: 'homeOrder2',value: homeOrderNumber2);
        }

      }
      if(homeOrderNumber3 !=0){
        if(name=='تعبئة أسطوانة غاز'){
          homeOrderNumber3=0;
          CashHelper.saveData(key: 'homeOrder3',value: homeOrderNumber3);
        }else{
          homeOrderNumber3=1;
          CashHelper.saveData(key: 'homeOrder3',value: homeOrderNumber3);
        }


      }
      if(homeOrderNumber4 !=0){
        if(name=='منظم غاز'){
          homeOrderNumber4=0;
          CashHelper.saveData(key: 'homeOrder4',value: homeOrderNumber4);
        }else{
          homeOrderNumber4=1;
          CashHelper.saveData(key: 'homeOrder4',value: homeOrderNumber4);
        }
      }

      getDeleteOrderDatabase(database2).then((value) {
        allSelected=value;
      });

      getService();
      emit(DeleteDatabaseSuccessState());
    });

  }

    Future updateOrderDatabase({required String name,required String newNumber})async{

     database2?.rawUpdate('UPDATE test SET favorite = ? WHERE name = ?', ['$newNumber', '$name']).then((value) {
      debugPrint('Item Update');
      getOrderDatabase(database2).then((value) {
        allSelected=value;
      });
      getService();
      emit(DeleteDatabaseSuccessState());
    });

  }

  TextEditingController firstName =TextEditingController();
  TextEditingController lastName =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController phoneNumber =TextEditingController();
  TextEditingController address =TextEditingController();


  // =============================================


  Future<void> uploadOrder({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String address,
    required int uId,
    required context
  })async{

    UserModel userModel=UserModel(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        address: address,
        email: email,
        totalPrice: totalPrice,
        uId: uId,
        selected: false,
        done: false,
    );

    emit(UploadUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc('${uId}').set(userModel.toMap()).then((value) {

      allSelected.forEach((element) {

        emit(UploadOrderLoadingState());

        FirebaseFirestore.instance.collection('users').doc('${uId}').collection('orders').add({

          'image':element['image'],
          'price':element['price'],
          'title':element['name'],
          'number':element['favorite'],

        }).then((value){
          emit(UploadOrderSuccessState());

        }).catchError((error){
          print('Error in upload order is ${error.toString()}');
          emit(UploadOrderErrorState());

        });

      });

      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image(
                height: MediaQuery.of(context).size.height*.07,
                width: MediaQuery.of(context).size.height*.04,
                color: ColorManager.primaryColor,
                image: const AssetImage('assets/images/doneIcon.png')
            ),
          ),
          content: Text(AppLocalizations.of(context)!.translate('orderSuccess').toString(),style: GoogleFonts.almarai(
              color: ColorManager.textColor,
              fontSize: 16
          ),
            textAlign: TextAlign.center,
          ),

        ),
      ).then((value) {
        this.firstName.text='';
        this.lastName.text='';
        this.email.text='';
        this.phoneNumber.text='';
        this.address.text='';
        getAllUserOrders();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
         StartScreen()), (Route<dynamic> route) => false);
      });


      emit(UploadUserSuccessState());


    }).catchError((error){

      print('Error in upload user is ${error.toString()}');
      emit(UploadUserErrorState());

    });

  }

  bool isCheckBoxTrue = false;

  void changeCheckBox({required bool value}){
    isCheckBoxTrue=value;
    emit(ChangeCheckBoxState());

  }

  Future <void> toPrivacy()async
  {
    String url= "https://github.com/MahmoudRede/gas_privacy_terms";
    await launch(url , forceSafariVC: false);
    emit(FacebookLaunchState());
  }

  List<UserModel>  allUsers=[];
  List<OrderModel> allOrders=[];
  List<UserModel> myUsersOrders=[];

  Future<void> getAllUserOrders()async{

    allUsers=[];
    emit(GetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {

      value.docs.forEach((element) {


        if(UserModel.fromFire(element.data()).done==false){

          allUsers.add(UserModel.fromFire(element.data()));

        }

      });

      print('all users lenght = ${allUsers.length}');

      emit(GetAllUsersSuccessState());

    }).catchError((error){

      debugPrint('Error in get allUsers is ${error.toString()}');

      emit(GetAllUsersErrorState());

    });



  }

  Future<void> getOrders({
   required int id,
    required context
  })async{

    allOrders=[];
    emit(GetOrdersLoadingState());
    FirebaseFirestore.instance.collection('users').doc('${id}').collection('orders').get().then((value) {

      value.docs.forEach((element) {

        allOrders.add(OrderModel.fromFire(element.data()));

      });

      Navigator.push(context, MaterialPageRoute(builder: (_){
        return const ViewOrderScreen();
      }));

      emit(GetOrdersSuccessState());

    }).catchError((error){

      debugPrint('Error in get orders is ${error.toString()}');

      emit(GetOrdersErrorState());

    });

  }


  Future<void> selectedUserOrder({
    required int id,
    required String firstName,
    required String email,
    required String phoneNumber,
    required String address,
    required int totalPrice,

   })async{

    emit(UpdateOrdersLoadingState());
    FirebaseFirestore.instance.collection('users').doc('${id}').update({
      'selected':true
    }).then((value) {

      insertSelectedOrdersDatabase(
          firstName: firstName,
          uId: id,
          address: address,
          email: email,
          phoneNumber: phoneNumber,
          totalPrice: totalPrice,
      );

      getAllUserOrders();

      debugPrint('UpdateOrders Success');
      emit(UpdateOrdersSuccessState());

    }).catchError((error){

      debugPrint('Error in get UpdateOrders is ${error.toString()}');

      emit(UpdateOrdersErrorState());

    });
  }


  Database ?database3;
  List <Map> selectedOrders=[];


  void createSelectedOrdersDatabase() async {

    return await openDatabase(
        'selectedOrder.db',
        version: 1,
        onCreate: (database,version){
          database.execute(
              'CREATE TABLE selectedOrder (id INTEGER PRIMARY KEY , name TEXT , address TEXT, price TEXT, rate TEXT, image TEXT, favorite TEXT)'
          ).then((value) {
            print('Table Created');
            emit(CreateTableState());
          });
        },
        onOpen: (database){
          getSelectedOrdersDatabase(database).then((value){
            selectedOrders=value;
          }).catchError((error){
            print('error i ${error.toString()}');
          });
          print('Database Opened');
        }

    ).then((value) {
      database3=value;
      print('Database Created');
      emit(CreateDatabaseSuccessState());
    }).catchError((error){
      print('error is ${error.toString()}');
      emit(CreateDatabaseErrorState());

    });
  }

  Future insertSelectedOrdersDatabase(
      {
        required String email,
        required int uId,
        required String firstName,
        required String phoneNumber,
        required int totalPrice,
        required String address,
      }) async{

    return database3?.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO selectedOrder (name,address,price,rate,image,favorite) VALUES ( "${email}" , "${firstName}" , "${address}" , "${phoneNumber}" , "${totalPrice}" , "${uId}")'
      ).then((value) {
        print("${value} Insert Success");
        emit(InsertDatabaseSuccessState());
        getSelectedOrdersDatabase(database3).then((value){
          selectedOrders=value;
        });
        customToast(title: 'Item added to your orders', color: ColorManager.red);
        emit(InsertDatabaseSuccessState());

      }).catchError((error){
        print('Error is ${error.toString()}');
      });

    });

  }


  Future <List<Map>> getSelectedOrdersDatabase(database)async {

    selectedOrders=[];

    return await database?.rawQuery(
        'SELECT * FROM selectedOrder'
    ).then((value) {

      value.forEach((element){


        selectedOrders.add(element);


      });


      print(selectedOrders);
      emit(GetDatabaseSuccessState());
    }).catchError((error){
      print('GetError is ${error.toString()}');
    });
  }

  Future deleteSelectedOrdersDatabase({required String name})async{

    return await database3?.rawDelete('DELETE FROM selectedOrder WHERE name = ?', [name]).then((value) {
      debugPrint('Item Deleted');
      customToast(title: 'Item deleted form your orders', color: ColorManager.red);
      getSelectedOrdersDatabase(database3).then((value) {
        selectedOrders=value;
      });
      emit(DeleteDatabaseSuccessState());
    });

  }

  Future<void> unSelectedUserOrder({
    required int id,


  })async{

    emit(UpdateOrdersLoadingState());
    FirebaseFirestore.instance.collection('users').doc('${id}').update({
      'selected':false
    }).then((value) {

      getAllUserOrders();

      debugPrint('UpdateOrders Success');
      emit(UpdateOrdersSuccessState());

    }).catchError((error){

      debugPrint('Error in get UpdateOrders is ${error.toString()}');

      emit(UpdateOrdersErrorState());

    });
  }


  List<bool> isDone=List.generate(100, (index) => false);

  void orderDone(value,int index){

    isDone[index]=value;
    emit(UpdateOrdersErrorState());

  }

  Future<void> doneUserOrder({
    required int id,
  })async{

    emit(UpdateOrdersLoadingState());
    FirebaseFirestore.instance.collection('users').doc('${id}').update({
      'done':true
    }).then((value) {

      getAllUserOrders();

      debugPrint('UpdateOrders Success');
      emit(UpdateOrdersSuccessState());

    }).catchError((error){

      debugPrint('Error in get UpdateOrders is ${error.toString()}');

      emit(UpdateOrdersErrorState());

    });
  }


  Future<void> userRegister ({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  })async{

    emit(UserRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {

      saveUser(
        id: value.user!.uid,
        phoneNumber: phoneNumber,
        email: email,
        name: name,
      );

      getDrivers();

      emit(UserRegisterSuccessState());
    }).catchError((error){

      debugPrint('Error in userRegister is ${error.toString()}');
      emit(UserRegisterErrorState());

    });


  }


  Future<void> saveUser({
    required String name,
    required String email,
    required String phoneNumber,
    required String id,
  })async{

    emit(SaveUserLoadingState());

    DriverModel driverModel=DriverModel(
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        uId: id,
        isVerified: false
    );

    FirebaseFirestore.instance.
    collection('Drivers').
    doc(id).
    set(driverModel.toMap()).then((value) {

      debugPrint('Save Diver Success');

      emit(SaveUserSuccessState());
    }).catchError((error){

      debugPrint('Error in userRegister is ${error.toString()}');
      emit(SaveUserErrorState());

    });

  }


  Future<void> userLogin ({
    required String email,
    required String password,
  })async{

    emit(UserLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {

      getUser(id: value.user!.uid);

      debugPrint('Driver Login Success');
      emit(UserLoginSuccessState());
    }).catchError((error){

      debugPrint('Error in userRegister is ${error.toString()}');
      emit(UserLoginErrorState());

    });


  }

  DriverModel ?driverModel;

  Future<void> getUser({
    required String id,
  })async{

    emit(GetUserLoadingState());

    FirebaseFirestore.instance.
    collection('Drivers').
    doc(id).
    get().then((value) {


      driverModel=DriverModel.fromFire(value.data()!);

      debugPrint('get Diver Success');

      emit(GetUserSuccessState());
    }).catchError((error){

      debugPrint('Error in getUser is ${error.toString()}');
      emit(GetUserErrorState());

    });

  }


  List<DriverModel> allDrivers=[];
  Future<void> getDrivers()async{

    emit(GetUsersLoadingState());

    FirebaseFirestore.instance.
    collection('Drivers').
    get().then((value) {

      allDrivers=[];
      value.docs.forEach((element) {

        if(DriverModel.fromFire(element.data()).isVerified ==false){
          allDrivers.add(DriverModel.fromFire(element.data()));
        }
      });

      debugPrint('get All Divers Success');

      emit(GetUsersSuccessState());
    }).catchError((error){

      debugPrint('Error in getDrivers is ${error.toString()}');
      emit(GetUsersErrorState());

    });

  }


  Future<void> updateUser({
    required String id,
    required context,
  })async{

    emit(UpdateUserLoadingState());

    FirebaseFirestore.instance.
    collection('Drivers').
    doc(id).
    update({
      'isVerified':true
    }).then((value) {

      customToast(title: AppLocalizations.of(context)!.translate('driverAccept').toString(), color: Colors.red);
      getDrivers();

      debugPrint('Update Diver Success');

      emit(UpdateUserSuccessState());
    }).catchError((error){

      debugPrint('Error in UpdateUser is ${error.toString()}');
      emit(UpdateUserErrorState());

    });

  }


  Future<void> deleteUser({
    required String id,
    required context,
  })async{

    emit(DeleteUserLoadingState());

    FirebaseFirestore.instance.
    collection('Drivers').
    doc(id).
    delete().then((value) {

      customToast(title:AppLocalizations.of(context)!.translate('driverRefuse').toString(), color: Colors.red);
      getDrivers();

      debugPrint('Delete Diver Success');

      emit(DeleteUserSuccessState());
    }).catchError((error){

      debugPrint('Error in DeleteUser is ${error.toString()}');
      emit(DeleteUserErrorState());

    });

  }



  Future<void> deleteOrder({
    required int id,
  })async{

    emit(DeleteUserLoadingState());

    FirebaseFirestore.instance.
    collection('users').
    doc('${id}').
    delete().then((value) {


      getAllUserOrders();

      debugPrint('Delete order Success');

      emit(DeleteUserSuccessState());
    }).catchError((error){

      debugPrint('Error in Deleteorder is ${error.toString()}');
      emit(DeleteUserErrorState());

    });

  }
}