import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:alerte_ethique/models/api_response.dart';
import 'package:alerte_ethique/models/mesSignalements.dart';
import 'package:alerte_ethique/services/http_services.dart';
import 'package:alerte_ethique/widgets/snack_bar_helper.dart';

class MessignalementsProvider with ChangeNotifier {
  HttpService service = HttpService();

  List<MesSignalements> _allSignalements = [];
  List<MesSignalements> _filteredSignalements = [];
  List<MesSignalements> get signalements => _filteredSignalements;

  //getAllSignalement

  Future<List<MesSignalements>> getAllSignalement(
      {bool showSnack = false}) async {
    try {
      final box = GetStorage();
      final userid = box.read('user_id');
      Response response =
          await service.getItems(endpointUrl: 'mesSignalements/$userid');
      print('mesSignalements/$userid');
      if (response.isOk) {
        ApiResponse<List<MesSignalements>> apiResponse =
            ApiResponse<List<MesSignalements>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => MesSignalements.fromJson(item))
                    .toList());
        _allSignalements = apiResponse.data ?? [];
        _filteredSignalements = List.from(_allSignalements);
        notifyListeners();
        if (showSnack)
          SnackBarHelper.showSuccessSnackBar(
              "types Signalements actualisés avec succès");
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredSignalements;
  }
}
