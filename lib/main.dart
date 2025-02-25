import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:alerte_ethique/authentication/login_page.dart';
import 'package:alerte_ethique/core/data/data_provider.dart';
import 'package:alerte_ethique/home/home_screen.dart';
import 'package:alerte_ethique/home/provider/home_screen_provider.dart';
import 'package:alerte_ethique/home/provider/mesSignalements_provider.dart';
import 'package:alerte_ethique/home/provider/status_provider.dart';
import 'package:alerte_ethique/utility/extensions.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialise GetStorage
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
    print('Token lors du build du MyApp: $token');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title:  'Alerte Éthique',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: token==null?  LoginPage():  HomeScreen(),
    );
  }
}

