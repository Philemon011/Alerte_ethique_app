import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:alerte_ethique/home/provider/mesSignalements_provider.dart';
import 'package:alerte_ethique/models/api_response.dart';
import 'package:alerte_ethique/models/typeSignalement.dart';
import 'package:alerte_ethique/services/http_services.dart';
import 'package:alerte_ethique/widgets/snack_bar_helper.dart';
import 'package:get/get.dart';

import '../../core/data/data_provider.dart';
import '../../utility/constants.dart';

class HomeScreenProvider with ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final MessignalementsProvider messignalementsProvider =
      MessignalementsProvider();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();

  DateTime? selectedDate;
  File? selectedFile;
  int currentIndex = 0;
  TypeSignalement? selectedTypeSignalement;
  List<TypeSignalement> typeSignalements = [];
  bool isloading = false;

  HomeScreenProvider(this._dataProvider);

  Future<void> fetchTypeSignalement() async {
    try {
      typeSignalements = await _dataProvider.getAllTypeSignalement();
      // print("Types de signalement récupérés : $typeSignalements");
      notifyListeners();
    } catch (e) {
      SnackBarHelper.showErrorSnackBar(
          'Erreur lors du chargement des types de signalement: $e');
    }
  }

  // Méthode pour sélectionner la date
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateCtrl.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
      notifyListeners();
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null) {
      selectedFile = File(result.files.single.path!);
      notifyListeners();
    }
  }

  void updateNavigationIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  updateUI() {
    notifyListeners();
  }

  Future<FormData> createFormData(
      {required File? pieceXFile,
      required Map<String, dynamic> formData}) async {
    if (pieceXFile != null) {
      MultipartFile multipartFile;

      String fileName = pieceXFile.path.split('/').last;
      multipartFile = MultipartFile(pieceXFile.path, filename: fileName);

      formData['piece_jointe'] = multipartFile;
    }
    final FormData form = FormData(formData);
    return form;
  }

  addSignalement() async {
    final box = GetStorage();
    // final token = box.read('token');
    final id = box.read('user_id') ?? null;
    isloading = true;

    notifyListeners();
    try {
      Map<String, dynamic> formDataMap = {
        'type_de_signalement_id': selectedTypeSignalement?.id,
        'description': descriptionCtrl.text,
        'date_evenement': dateCtrl.text,
        'piece_jointe': null, // image path will add from server side
        'user_id': id,
      };

      final FormData form =
          await createFormData(pieceXFile: selectedFile, formData: formDataMap);

      final response = await service.addItem(
        endpointUrl: 'signalement',
        itemData: form,
      );
      print("Réponse du backend: $response");
      // Traitement de la réponse
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          isloading = false;
          SnackBarHelper.showSuccessSnackBar("Signalement ajouté avec succès");
          messignalementsProvider.getAllSignalement();
          // Get.defaultDialog(
          //   barrierDismissible: false,
          //   radius: 0,
          //   title: "Code de suivi",
          //   content: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Text(
          //         "Voici votre code :",
          //         style: TextStyle(fontSize: 16, color: Colors.black),
          //       ),
          //       SizedBox(height: 10),
          //       Container(
          //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //         decoration: BoxDecoration(
          //           color: Colors.green[50],
          //           border: Border.all(color: Colors.green, width: 1),
          //           borderRadius: BorderRadius.circular(0),
          //         ),
          //         child: GestureDetector(
          //           onTap: () {
          //             Clipboard.setData(ClipboardData(
          //                 text:
          //                     "${response.body?['code_de_suivi'] ?? response.statusText}"));
          //             Get.snackbar(
          //               "Succès",
          //               "Code copié dans le presse-papiers",
          //               snackPosition: SnackPosition.BOTTOM,
          //               // backgroundColor: Colors.green,
          //               colorText: Colors.white,
          //             );
          //           },
          //           child: Text(
          //             "${response.body?['code_de_suivi'] ?? response.statusText}",
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.green,
          //             ),
          //           ),
          //         ),
          //       ),
          //       SizedBox(height: 10),
          //       Text(
          //         "Gardez-le jalousement pour pouvoir vérifier le statut de votre requête.",
          //         style: TextStyle(fontSize: 16, color: Colors.black),
          //       ),
          //     ],
          //   ),
          //   confirm: ElevatedButton(
          //     onPressed: () {
          //       Clipboard.setData(ClipboardData(
          //                 text:
          //                     "${response.body?['code_de_suivi'] ?? response.statusText}"));

          //       Get.back(); // Ferme le dialog
          //     },
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor:
          //           primaryColor, // Couleur personnalisée du bouton
          //       shape: RoundedRectangleBorder(
          //         borderRadius:
          //             BorderRadius.circular(0), // Coins arrondis personnalisés
          //       ),
          //     ),
          //     child: Text(
          //       "C'est fait",
          //       style: TextStyle(color: Colors.white), // Couleur du texte
          //     ),
          //   ),
          // );
        } else {
          isloading = false;
          SnackBarHelper.showErrorSnackBar(
              'Erreur lors de l\'ajout du Signalement');
          print(
              'Erreur lors de l\'ajout du Signalement : ${apiResponse.message}');
        }
      } else {
        isloading = false;
        SnackBarHelper.showErrorSnackBar(
            'Error ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      isloading = false;
      print(e);
      SnackBarHelper.showErrorSnackBar('Une erreur s\'est produite $e');
      rethrow;
    } finally {
      isloading = false;
      notifyListeners(); // Notifiez à la fin pour indiquer que le chargement est terminé
    }
  }

  // Soumission du formulaire
  void submitForm() {
    if (selectedTypeSignalement == null || descriptionCtrl.text.isEmpty || dateCtrl.text.isEmpty) {
      SnackBarHelper.showErrorSnackBar('Tous les champs doivent être remplis');
      return;
    }
    addSignalement();
    clearFields();

    // print("Type Signalement ID: ${selectedTypeSignalement?.id}");
    // print("Type Signalement Libelle: ${selectedTypeSignalement?.libelle}");
    // print("Description new: ${descriptionCtrl.text}");
    // if (selectedFile != null) {
    //   print("Fichier sélectionné: ${selectedFile!.path}");
    // }
  }

  clearFields() {
    descriptionCtrl.clear();
    selectedFile = null;
  }
}
