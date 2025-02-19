import 'package:flutter/material.dart';
import 'package:lnb_ethique_app/core/data/data_provider.dart';
import 'package:lnb_ethique_app/home/components/home_page.dart';
import 'package:lnb_ethique_app/home/provider/home_screen_provider.dart';
import 'package:lnb_ethique_app/models/typeSignalement.dart';
import 'package:lnb_ethique_app/pages/profilePage/profilePage.dart';
import 'package:lnb_ethique_app/utility/constants.dart';
import 'package:lnb_ethique_app/utility/extensions.dart';
import 'package:lnb_ethique_app/widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';

import '../pages/faqs/faqsPage.dart';
import '../pages/mesSignalements/mesSignalements.dart';
import 'provider/home_screen_provider.dart';

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
          // Faqspage(),
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
