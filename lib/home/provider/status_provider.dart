import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alerte_ethique/models/api_response.dart';
import 'package:alerte_ethique/services/http_services.dart';
import 'package:alerte_ethique/utility/constants.dart';
import 'package:alerte_ethique/widgets/snack_bar_helper.dart';

class StatusProvider with ChangeNotifier {
  HttpService service = HttpService();
  TextEditingController codeDeSuiviCtrl = TextEditingController();
  bool isloading = false;

  void submitForm() {
    if (codeDeSuiviCtrl.text.isEmpty) {
      SnackBarHelper.showErrorSnackBar('Veuillez entrer le code de suivie');
      return;
    }
  }

  check() async {
    try {
      Map<String, dynamic> code = {
        'code_de_suivi': codeDeSuiviCtrl.text,
      };

      final response = await service.checkStatus(
          endpointUrl: 'getSignalementByCodeDeSuivi', itemData: code);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(
            response.body, (json) => json as Map<String, dynamic>);
        if (apiResponse.success == true) {
          // clearFields();
          Get.defaultDialog(
            titlePadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.all(10),
            barrierDismissible: false,
            radius: 0,
            title:
                "Status du Signalement ${response.body?['data']['code_de_suivi']}",
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Type de Signalement :",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${response.body?['data']['libelle']}",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  "Description :",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  (response.body?['data']['description'] ?? '').length > 100
                      ? "${response.body?['data']['description']?.substring(0, 100)}..."
                      : response.body?['data']['description'] ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  "Date de Création : ",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${response.body?['data']['created_at']}",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  "Status :",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: getColorForStatus("${response.body?['data']['nom_status']}")
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${response.body?['data']['nom_status']}",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
            confirm: ElevatedButton(
              onPressed: () {
                Get.back(); // Ferme le dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    primaryColor, // Couleur personnalisée du bouton
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(0), // Coins arrondis personnalisés
                ),
              ),
              child: Text(
                "Okay",
                style: TextStyle(color: Colors.white), // Couleur du texte
              ),
            ),
          );
        } else {
          // SnackBarHelper.showErrorSnackBar(
          //     'Erreur lors de la vérification du  Signalement ${apiResponse.message}');
          print(
              "Erreur lors de la vérification du  Signalement ${apiResponse.message}");
        }
      } else {
        // SnackBarHelper.showErrorSnackBar(
        //     'Error ${response.body?['message'] ?? response.statusText}');
        print('Error ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      // SnackBarHelper.showErrorSnackBar('Une erreur s\'est produite $e');
      print("Une erreur s\'est produite $e");
      rethrow;
    }
  }

  clearFields() {
    codeDeSuiviCtrl.clear();
  }

  Color getColorForStatus(String status) {
  switch (status) {
    case 'Non traité':
      return Color(0xFFFF3B30); // Rouge
    case 'En cours':
      return Color(0xFF007BFF); // Bleu clair
    case 'Résolu':
      return Color(0xFF28A745); // Vert
    case 'Rejeté':
      return Color(0xFFFFC107); // Orange
    default:
      return Colors.grey; // Couleur par défaut si le statut est inconnu
  }
}
}
