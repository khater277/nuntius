import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/calls/data/models/call_type/call_type.dart';
import 'package:nuntius/features/home/data/models/notification_data/notification_data.dart';
import 'package:uuid/uuid.dart';

class AppFunctions {
  static String? handleTextFieldValidator({
    required List<bool> conditions,
    required List<String> messages,
  }) {
    String? result;
    for (int i = 0; i < conditions.length; i++) {
      if (conditions[i]) {
        result = messages[i];
      }
      if (result != null) break;
    }
    return result;
  }

  static String generateCountryFlag({required String countryCode}) {
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }

  static Map<String, dynamic> getMessageNotificationFcmBody(
      {required UserData user}) {
    late String name;
    try {
      name = user.contacts![di<UserStorage>().getUser()!.phone!]!;
    } catch (error) {
      name = di<UserStorage>().getUser()!.phone!;
    }
    return {
      "to": user.token!,
      "priority": "high",
      "notification": {
        "title": "New Message",
        "body": "$name sent you new message.",
        "sound": "default"
      },
      "data": NotificationData(
              senderName: name,
              type: NotificationType.message,
              notificationDate: DateTime.now().toUtc().toString(),
              notificationId: const Uuid().v4(),
              senderID: di<UserStorage>().getUser()!.uId!,
              phoneNumber: di<UserStorage>().getUser()!.phone!,
              clickAction: "FLUTTER_NOTIFICATION_CLICK")
          .toJson(),
    };
  }

  static Map<String, dynamic> getCallNotificationFcmBody({
    required NotificationType notificationType,
    required String userToken,
    CallType? callType,
    String? rtcToken,
    String? channelName,
  }) {
    String callId = const Uuid().v4();
    final Map<String, dynamic> fcmBody = {
      "to": userToken,
      "priority": "high",
      "data": NotificationData(
              type: notificationType,
              notificationDate: DateTime.now()
                  .add(const Duration(seconds: 30))
                  .toUtc()
                  .toString(),
              notificationId: const Uuid().v4(),
              callId: callId,
              callType: callType,
              token: rtcToken,
              userToken: di<UserStorage>().getUser()!.token!,
              channelName: channelName,
              senderID: di<UserStorage>().getUser()!.uId!,
              phoneNumber: di<UserStorage>().getUser()!.phone!,
              clickAction: "FLUTTER_NOTIFICATION_CLICK")
          .toJson(),
    };

    return fcmBody;
  }

  static String storyDate(String date) {
    String? finalDate;
    DateTime storyDate = DateTime.parse(date);
    DateTime nowDate = DateTime.now();

    int minutesDiff = nowDate.difference(storyDate).inMinutes;
    if (minutesDiff >= 60) {
      finalDate =
          "${(minutesDiff / 60).floor()} ${(minutesDiff / 60).floor() == 1 ? "hour" : "hours"} ago";
    } else {
      if (minutesDiff == 0) {
        finalDate = "just now";
      } else {
        finalDate =
            "$minutesDiff ${minutesDiff == 1 ? "minute" : "minutes"} ago";
      }
    }

    return finalDate;
  }

  static Duration durationParser({required String duration}) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = duration.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  static String timeFormat(int time) {
    return time.toString().length == 1 ? "0$time" : "$time";
  }

  static String calculateCallTime({required int? data}) {
    int seconds = 0;
    int minutes = 0;
    int hours = 0;
    int total = 0;

    total = data != null ? int.parse(data.toString()) : 0;

    seconds = total % 60;
    minutes = (total / 60).floor() % 60;
    hours = (total / 3600).floor() % 3600;

    String text =
        "${timeFormat(hours) != "00" ? "${timeFormat(hours)}:" : ""}${timeFormat(minutes)}:${timeFormat(seconds)}";
    return text;
  }
}
