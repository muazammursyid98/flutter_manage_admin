import 'dart:convert';
import 'package:http/http.dart';

import '../model/expenditure_model.dart';
import '../service/expenditure_service.dart';

class ExpenditureController {
  final ExpenditureService _expenditureService = ExpenditureService();

  //get all expenditure

  Future<Expenditure?> getExpenditures() async {
    Expenditure? _expenditure;

    Response _response = await _expenditureService.getExpenditures();

    int statusCode = _response.statusCode;
    if (statusCode == 200) {
      //success
      var decoded = json.decode(_response.body);
      _expenditure = Expenditure.fromJson(decoded);
    } else {
      // print(statusCode);
      print('failed to decode');
      _expenditure = null;
    }
    return _expenditure;
  }

  // Get expenditure by userid
  Future<Expenditure?> getUserExpenditure(int id) async {
    Expenditure? _expenditure;

    Response _response = await _expenditureService.getExpendituresByUserId(id);
    int statusCode = _response.statusCode;
    if (statusCode == 200) {
      //success
      var decoded = json.decode(_response.body);
      _expenditure = Expenditure.fromJson(decoded);
    } else {
      // print(statusCode);
      print('failed to decode');
      _expenditure = null;
    }
    return _expenditure;
  }

  // Get expenditure by Stage
  Future<Expenditure?> getExpenditureStages(String stage) async {
    Expenditure? _expenditure;

    Response _response =
        await _expenditureService.getExpendituresByStage(stage);
    int statusCode = _response.statusCode;
    if (statusCode == 200) {
      //success
      var decoded = json.decode(_response.body);
      _expenditure = Expenditure.fromJson(decoded);
    } else {
      // print(statusCode);
      print('failed to decode');
      _expenditure = null;
    }
    return _expenditure;
  }

  // Get expenditure by Expenditure ID
  Future<Expenditure?> getExpenditureId(int expId) async {
    Expenditure? _expenditure;

    Response _response =
        await _expenditureService.getExpendituresByExpId(expId);
    int statusCode = _response.statusCode;
    if (statusCode == 200) {
      //success
      var decoded = json.decode(_response.body);
      _expenditure = Expenditure.fromJson(decoded);
    } else {
      // print(statusCode);
      print('failed to decode');
      _expenditure = null;
    }
    return _expenditure;
  }

  // Get expenditure by Map
  Future<Expenditure?> getExpenditure1map(String key, String value) async {
    Expenditure? _expenditure;

    Response _response =
        await _expenditureService.getExpendituresBy1map(key, value);
    int statusCode = _response.statusCode;
    if (statusCode == 200) {
      //success
      var decoded = json.decode(_response.body);
      _expenditure = Expenditure.fromJson(decoded);
    } else {
      // print(statusCode);
      print('failed to decode');
      _expenditure = null;
    }
    return _expenditure;
  }

  Future<Expenditure?> getExpenditure2map(
      String key1, String value1, String key2, String value2) async {
    Expenditure? _expenditure;

    Response _response = await _expenditureService.getExpendituresBy2map(
        key1, value1, key2, value2);
    int statusCode = _response.statusCode;
    if (statusCode == 200) {
      //success
      var decoded = json.decode(_response.body);
      _expenditure = Expenditure.fromJson(decoded);
    } else {
      // print(statusCode);
      print('failed to decode');
      _expenditure = null;
    }
    return _expenditure;
  }

  // Fetch uncompleted expenditure
  Future<Expenditure?> getUncompleteExpenditure(String key1, String value1,
      String key2, String value2, String key3, String value3) async {
    Expenditure? _expenditure;

    Response _response = await _expenditureService.getUncompletedExpenditure(
        key1, value1, key2, value2, key3, value3);
    int statusCode = _response.statusCode;
    if (statusCode == 200) {
      //success
      var decoded = json.decode(_response.body);
      _expenditure = Expenditure.fromJson(decoded);
    } else {
      // print('failed to decode');
      _expenditure = null;
    }
    return _expenditure;
  }

  // Update expenditure
  Future<bool> updateExpenditure({
    required int id,
    String? stage,
    double? amount,
    String? purpose,
    bool? approved,
    String? requester,
    String? approver,
    String? timestampApproved,
  }) async {
    bool success = false;

    var response = await _expenditureService.updateExpenditure(
        id: id,
        stage: stage,
        amount: amount,
        purpose: purpose,
        approved: approved,
        requester: requester,
        approver: approver,
        timestampApproved: timestampApproved);

    int statusCode = response.statusCode;
    if (statusCode == 201) {
      success = true;
    } else {
      print('failed to update');
    }

    return success;
  }

// create new Expenditures

//TODO: make requester required
  Future<bool> createExpenditure({
    required String stage,
    required double amount,
    required String purpose,
    required String category,
    String? requester,
    String? approver,
  }) async {
    bool success = false;
    var _response = await _expenditureService.createExpenditure(
      stage: stage,
      amount: amount,
      purpose: purpose,
      category: category,
      requester: requester,
      approver: approver,
    );

    // print(_response.body);
    // print(success);

    int statusCode = _response.statusCode;
    if (statusCode == 201) {
      success = true;
    } else {
      // print(statusCode);
      print('failed');
    }

    return success;
  }
}
