import 'package:http/http.dart';
import 'dart:convert';

class ExpenditureService {
  //Get all expenditures

  Future<Response> getExpenditures() async {
    String url =
        "https://expenditure-tracker-backend.thescienceset.com/expenditures";
    Uri uri = Uri.parse(url);
    Response result = await get(uri);

    // print(result);

    return result;
  }

  // get expenditure by Userid
  Future<Response> getExpendituresByUserId(int id) async {
    String url =
        "https://expenditure-tracker-backend.thescienceset.com/expenditures?requester=$id";
    Uri uri = Uri.parse(url);
    Response result = await get(uri);
    return result;
  }

  // get expenditure by stage
  Future<Response> getExpendituresByStage(String stage) async {
    String url =
        "https://expenditure-tracker-backend.thescienceset.com/expenditures?stage=$stage";
    Uri uri = Uri.parse(url);
    Response result = await get(uri);
    return result;
  }

  // get expenditure by Userid
  Future<Response> getExpendituresByExpId(int id) async {
    String url =
        "https://expenditure-tracker-backend.thescienceset.com/expenditures?id=$id";
    Uri uri = Uri.parse(url);
    Response result = await get(uri);
    return result;
  }

// get expenditure by id and stage
  Future<Response> getExpendituresByStageID(int id, String stage) async {
    String url =
        "https://expenditure-tracker-backend.thescienceset.com/expenditures?requester=$id&stage=$stage";
    Uri uri = Uri.parse(url);
    Response result = await get(uri);
    return result;
  }

  // Filter expenditure by one key:value pair
  Future<Response> getExpendituresBy1map(String key, String value) async {
    String url =
        "https://expenditure-tracker-backend.thescienceset.com/expenditures?$key=$value";
    Uri uri = Uri.parse(url);
    Response result = await get(uri);
    return result;
  }

// Filter expenditure by 2 key:value pair
  Future<Response> getExpendituresBy2map(
      String key1, String value1, String key2, String value2) async {
    String url =
        "https://expenditure-tracker-backend.thescienceset.com/expenditures?$key1=$value1&$key2=$value2";
    Uri uri = Uri.parse(url);
    Response result = await get(uri);
    return result;
  }

// Get uncompleted expenditures
  Future<Response> getUncompletedExpenditure(String key1, String value1,
      String key2, String value2, String key3, String value3) async {
    String url =
        "https://expenditure-tracker-backend.thescienceset.com/expenditures?$key1=$value1||$key2=$value2&$key3=$value3";
    Uri uri = Uri.parse(url);
    Response result = await get(uri);
    return result;
  }

  // Update expenditure
  Future<Response> updateExpenditure({
    required int id,
    String? stage,
    double? amount,
    String? purpose,
    //changed to string
    String? requester,
    String? approver,
    String? payer,
    String? category,
    bool? approved,
    String? timestampRequest,
    String? timestampApproved,
    List? attachments,
  }) {
    return put(
      Uri.parse(
          "https://expenditure-tracker-backend.thescienceset.com/expenditures/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'stage': stage,
        'amount': amount,
        'purpose': purpose,
        'requester': requester,
        'approver': approver,
        'payer': payer,
        'category': category,
        'approved': approved,
        'timestamp_request': timestampRequest,
        'timestamp_approved': timestampApproved,
        'attachments': attachments,
      }),
    );
  }

  // create new expenditure
  Future<Response> createExpenditure({
    int? id,
    String? stage,
    double? amount,
    String? purpose,
    String? requester,
    String? approver,
    String? payer,
    String? category,
    bool? approved,
    String? timestampRequest,
    String? timestampApproved,
    List? attachments,
  }) {
    return post(
      Uri.parse(
          "https://expenditure-tracker-backend.thescienceset.com/expenditures"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'stage': stage,
        'amount': amount,
        'purpose': purpose,
        'requester': requester,
        'approver': approver,
        'payer': payer,
        'category': category,
        'approved': approved,
        'timestamp_request': timestampRequest,
        'timestamp_approved': timestampApproved,
        'attachments': attachments,
      }),
    );
  }

//delete expenditure

}
