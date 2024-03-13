import 'package:meta/meta.dart';
import 'dart:convert';

GameDetails gameDetailsFromJson(String str) =>
    GameDetails.fromJson(json.decode(str));

String gameDetailsToJson(GameDetails data) => json.encode(data.toJson());

class GameDetails {
  String message;
  int status;
  Result result;

  GameDetails({
    required this.message,
    required this.status,
    required this.result,
  });

  factory GameDetails.fromJson(Map<String, dynamic> json) => GameDetails(
        message: json["message"],
        status: json["status"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "result": result.toJson(),
      };
}

class Result {
  String allCount;
  String activeCount;
  String pendingCount;
  String rejectCount;

  Result({
    required this.allCount,
    required this.activeCount,
    required this.pendingCount,
    required this.rejectCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        allCount: json["all_count"] != null ? json["all_count"] : '',
        activeCount: json["active_count"] != null ? json["active_count"] : '',
        pendingCount:
            json["pending_count"] != null ? json["pending_count"] : '',
        rejectCount: json["reject_count"] != null ? json["reject_count"] : '',
      );

  Map<String, dynamic> toJson() => {
        "all_count": allCount,
        "active_count": activeCount,
        "pending_count": pendingCount,
        "reject_count": rejectCount,
      };
}
