import 'package:flutter/material.dart';
import 'package:flutter_easy_faq/flutter_easy_faq.dart';
import 'package:alerte_ethique/utility/constants.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class Faqspage extends StatefulWidget {
  const Faqspage({super.key});

  @override
  State<Faqspage> createState() => _FaqspageState();
}

class _FaqspageState extends State<Faqspage> {

  List<dynamic> faqData = [];

  @override
  void initState() {
    super.initState();
    loadFaqData();
  }

  Future<void> loadFaqData() async {
  try {
    final String response = await rootBundle.loadString('lib/pages/faqs/faqs.json');
    final data = json.decode(response);
    setState(() {
      faqData = data;
    });
  } catch (e) {
    print("Erreur lors du chargement du fichier JSON : $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text("Foire aux Questions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          faqData.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
          shrinkWrap: true,
            itemCount: faqData.length,
            itemBuilder: (context, index) {
              return EasyFaq(
                questionTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                anserTextStyle: TextStyle(fontSize: 16),
                borderRadius: BorderRadius.circular(4),
                backgroundColor: appBarColor,
                question: faqData[index]['question'],
                answer: faqData[index]['answer'],
              );
            },
          ),
        ],
      ),
    );
  }
}
