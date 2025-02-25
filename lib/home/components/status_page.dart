import 'package:flutter/material.dart';
import 'package:alerte_ethique/home/provider/status_provider.dart';
import 'package:alerte_ethique/utility/constants.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Verification du Status",
            style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
          ),
          backgroundColor: appBarColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 10,
                ),
                const Text(
                  'Entrez votre code de vérification',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: statusProvider.codeDeSuiviCtrl,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'XYZ-678E08111182C',
                      hintStyle: TextStyle(color: Colors.grey)),
                  maxLines: 1,
                ),
                const SizedBox(height: 30),
                Container(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      statusProvider.submitForm();
                      statusProvider.check();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero)),
                    child: const Text('Vérifier',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
