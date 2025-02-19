import 'package:get_storage/get_storage.dart';
import 'package:lnb_ethique_app/models/mesSignalements.dart';
import 'package:lnb_ethique_app/models/status.dart';
import '../../models/typeSignalement.dart';

import '../../models/api_response.dart';

import '../../services/http_services.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../widgets/snack_bar_helper.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  List<TypeSignalement> _allTypeSignalements = [];
  List<TypeSignalement> _filteredTypeSignalements = [];
  List<TypeSignalement> get typeSignalements => _filteredTypeSignalements;

  List<Status> _allStatus = [];
  List<Status> _filteredStatus = [];
  List<Status> get status => _filteredStatus;

  

  DataProvider() {
    getAllTypeSignalement();
    getAllStatus();
  }

  
  //getAllTypeSignalement

  Future<List<TypeSignalement>> getAllTypeSignalement(
      {bool showSnack = false}) async {
    try {
      Response response =
          await service.getItems(endpointUrl: 'typeSignalement');
      if (response.isOk) {
        ApiResponse<List<TypeSignalement>> apiResponse =
            ApiResponse<List<TypeSignalement>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => TypeSignalement.fromJson(item))
                    .toList());
        _allTypeSignalements = apiResponse.data ?? [];
        _filteredTypeSignalements = List.from(_allTypeSignalements);
        notifyListeners();
        if (showSnack)
          SnackBarHelper.showSuccessSnackBar(
              "types Signalements actualisés avec succès");
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredTypeSignalements;
  }

  //TODO: should complete filterTypeSignalements
  void filterTypeSignalements(String keyword) {
    if (keyword.isEmpty) {
      _filteredTypeSignalements = List.from(_allTypeSignalements);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredTypeSignalements = _allTypeSignalements.where((typeSignalement) {
        return (typeSignalement.libelle ?? "")
            .toLowerCase()
            .contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //TODO: should complete getAllStatus

  Future<List<Status>> getAllStatus({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'status');
      if (response.isOk) {
        ApiResponse<List<Status>> apiResponse =
            ApiResponse<List<Status>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => Status.fromJson(item))
                    .toList());
        _allStatus = apiResponse.data ?? [];
        _filteredStatus = List.from(_allStatus);
        notifyListeners();
        if (showSnack)
          SnackBarHelper.showSuccessSnackBar(
              "Liste des Status actualisés avec succès");
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredStatus;
  }

  //TODO: should complete filterTypeSignalements
  void filteredStatus(String keyword) {
    if (keyword.isEmpty) {
      _filteredStatus = List.from(_allStatus);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredStatus = _allStatus.where((status) {
        return (status.nom_status ?? "").toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }
}
