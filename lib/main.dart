import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lnb_ethique_app/authentication/login_page.dart';
import 'package:lnb_ethique_app/core/data/data_provider.dart';
import 'package:lnb_ethique_app/home/home_screen.dart';
import 'package:lnb_ethique_app/home/provider/home_screen_provider.dart';
import 'package:lnb_ethique_app/home/provider/mesSignalements_provider.dart';
import 'package:lnb_ethique_app/home/provider/status_provider.dart';
import 'package:lnb_ethique_app/utility/extensions.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => HomeScreenProvider(context.dataProvider)),
        ChangeNotifierProvider(create: (context) => StatusProvider()),
        ChangeNotifierProvider(create: (context) => MessignalementsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title:  'Alerte Éthique',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: token==null? const LoginPage(): const HomeScreen(),
    );
  }
}

