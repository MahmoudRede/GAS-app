import 'package:flutter/services.dart';
import 'package:gas/business_logic/localization_cubit/app_localization.dart';
import 'package:gas/presentation/screens/home_screen/screen/home_screen.dart';
import 'package:gas/presentation/screens/start_screen/screen/start_screen.dart';
import 'package:gas/style/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    Future.delayed(const Duration(seconds: 2),(){

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          const StartScreen()), (Route<dynamic> route) => false);

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: ColorManager.primaryColor ,
      appBar: AppBar(
        elevation: 0.0,
      ),

      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.1,),
            Hero(
              tag: 'splash',
              child: Image(
                  image: const AssetImage('assets/images/gas.png'),
                  height: MediaQuery.of(context).size.height*.28,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.03,),
            Text(AppLocalizations.of(context)!.translate('appName').toString(),style: GoogleFonts.almarai(
                fontWeight: FontWeight.w700,
                fontSize: MediaQuery.of(context).size.height*.045,
                color: ColorManager.black
            ),),

            SizedBox(height: MediaQuery.of(context).size.height*.05,),

            Text('أنت أطلب و إحنا نوصل',style: GoogleFonts.almarai(
                fontWeight: FontWeight.w700,
                fontSize: MediaQuery.of(context).size.height*.035,
                color: ColorManager.black),
              textAlign: TextAlign.center,
            ),





          ],
        ),
      ),

    );
  }
}