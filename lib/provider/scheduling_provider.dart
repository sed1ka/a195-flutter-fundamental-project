import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:dicoding_news_app/utils/background_service.dart';
import 'package:dicoding_news_app/utils/date_time_helper.dart';
import 'package:flutter/material.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling News Activated');
      notifyListeners();
      return await AndroidAlarmManager.oneShotAt(
        DateTimeHelper.format(),
        1,
        BackgroundService.callback,
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling News Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}