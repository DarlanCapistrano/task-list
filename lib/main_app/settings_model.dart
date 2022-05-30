import 'package:my_tasks/util/color_theme.dart';

class Settings {
  final AppTheme appTheme;

  Settings({required this.appTheme});

  factory Settings.fromMap(Map<String, dynamic> map){
    return Settings(
      appTheme: map["appTheme"] == "white" ? AppTheme.white : AppTheme.dark,
    );
  }
}