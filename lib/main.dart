import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gas/business_logic/app_cubit/app_cubit.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/business_logic/localization_cubit/localization_cubit.dart';
import 'package:gas/business_logic/localization_cubit/localization_states.dart';
import 'package:gas/presentation/screens/home_screen/screen/home_screen.dart';
import 'package:gas/presentation/screens/splash_screen/screen/splash_screen.dart';
import 'package:gas/style/app_color.dart';
import 'firebase_options.dart';
import 'package:gas/utils/local/cash_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await CashHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) =>AppCubit()..getService()..createDatabase()..getDrivers()..createOrderDatabase()..getAllUserOrders()..createSelectedOrdersDatabase()),
        BlocProvider(create: (BuildContext context) => LocalizationCubit()..fetchLocalization()),
      ],
      child: BlocConsumer<LocalizationCubit,LocalizationStates>(
        listener: (context,state){

        },
        builder: (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.grey[200],
              appBarTheme: AppBarTheme(
                color: ColorManager.primaryColor,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: ColorManager.primaryColor,
                  statusBarBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.dark
                ),
              )
            ),
            home: const SplashScreen(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            supportedLocales:  const [

              Locale("en",""),
              Locale("ar",""),
            ],
            locale: LocalizationCubit.get(context).appLocal,
            localeResolutionCallback: (currentLang , supportLang){
              if(currentLang != null) {
                for(Locale locale in supportLang){
                  if(locale.languageCode == currentLang.languageCode){
                    return currentLang;
                  }
                }
              }
              return supportLang.first;
            },
          );
        },
      ),
    );
  }
}
