import 'package:flutter/material.dart';
import 'package:alerte_ethique/core/data/data_provider.dart';
import 'package:alerte_ethique/home/components/home_page.dart';
import 'package:alerte_ethique/home/provider/home_screen_provider.dart';
import 'package:alerte_ethique/models/typeSignalement.dart';
import 'package:alerte_ethique/pages/profilePage/profilePage.dart';
import 'package:alerte_ethique/utility/constants.dart';
import 'package:alerte_ethique/utility/extensions.dart';
import 'package:alerte_ethique/widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';

import '../pages/mesSignalements/mesSignalements.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Charger les statuts au démarrage
    Future.microtask(() {
      context.read<HomeScreenProvider>().fetchTypeSignalement();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeScreenProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alerte Éthique',
          style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
        ),
        backgroundColor: appBarColor,
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },)
        ],
      ),
      body: IndexedStack(
        index: homeProvider.currentIndex,
        children: [
          HomePage(),
          MesSignalementspage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: homeProvider.currentIndex,
        onTap: (index) => homeProvider.updateNavigationIndex(index),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.messenger_rounded), label: 'Mes Signalements'),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.question_answer), label: 'FAQs'),
        ],
      ),
    );
  }
}
