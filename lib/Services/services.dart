import 'dart:convert';

import 'package:google/Api/api.dart';
import 'package:google/models/leavehistory_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Services {
  static Future<List<LeaveHistory>> leavehistory() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var student_id = session.getInt('student_id');

    List<LeaveHistory> users = [];

    Map data = {'student_id': student_id.toString()};
    print('-----xxx----');
    // print(data);
    var url = History;
    var urlparse = Uri.parse(url);

    final response = await http.post(urlparse, body: data);
    print(urlparse);
    print(data);

    var responseBody = json.decode(response.body.toString());
    print(responseBody);
    if (response.statusCode == 200) {
      users = LeaveHistoryResponse(jsonEncode(responseBody['results']));
      // print(list);
      return users;
      // Map<String, dynamic> map = json.decode(response.body);
      // List<dynamic> jsonResponse = map["results"];
      // return jsonResponse
      //     .map((data) => new LeaveHistory.fromJson(data))
      //     .toList();
    } else {
      throw Exception("Problem in fetching ");
    }
    // return list;
  }

  static List<LeaveHistory> LeaveHistoryResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<LeaveHistory>((json) => LeaveHistory.fromJson(json))
        .toList();
  }
}
