// To parse this JSON data, do
//
//     final leaveHistory = leaveHistoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<LeaveHistory> leaveHistoryFromJson(String str) => List<LeaveHistory>.from(
    json.decode(str).map((x) => LeaveHistory.fromJson(x)));

String leaveHistoryToJson(List<LeaveHistory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveHistory {
  String id;
  String studentId;
  String requestType;
  String reasonType;
  String fromDate;
  String fromTime;
  String toDate;
  String toTime;
  String status;
  String principalStatus;
  String parentsStatus;
  String statusOpen;
  String createdAt;
  String updatedAt;
  String firstName;
  String lastName;
  String statusText;

  LeaveHistory({
    required this.id,
    required this.studentId,
    required this.requestType,
    required this.reasonType,
    required this.fromDate,
    required this.fromTime,
    required this.toDate,
    required this.toTime,
    required this.status,
    required this.principalStatus,
    required this.parentsStatus,
    required this.statusOpen,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.statusText,
  });

  factory LeaveHistory.fromJson(Map<String, dynamic> json) => LeaveHistory(
        id: json["id"] != null ? json["id"].toString() : '',
        studentId: json["student_id"].toString() != null
            ? json["student_id"].toString()
            : '',
        requestType:
            json["request_type"] != null ? json["request_type"].toString() : '',
        reasonType:
            json["reason_type"] != null ? json["reason_type"].toString() : '',
        fromDate: json["from_date"] != null ? json["from_date"] : '',
        fromTime: json["from_time"],
        toDate: json["to_date"],
        toTime: json["to_time"],
        status: json["status"].toString(),
        principalStatus: json["principal_status"].toString(),
        parentsStatus: json["parents_status"].toString(),
        statusOpen: json["status_open"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        firstName:
            json["first_name"] != null ? json["first_name"].toString() : '',
        lastName: json["last_name"] != null ? json["last_name"].toString() : '',
        statusText:
            json["status_text"] != null ? json["status_text"].toString() : '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "request_type": requestType,
        "reason_type": reasonType,
        "from_date": fromDate,
        "from_time": fromTime,
        "to_date": toDate,
        "to_time": toTime,
        "status": status,
        "principal_status": principalStatus,
        "parents_status": parentsStatus,
        "status_open": statusOpen,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "first_name": firstName,
        "last_name": lastName,
        "status_text": statusText,
      };
}
