import 'package:flutter/material.dart';
import 'package:my_tasks/main_app/main_app_controller.dart';
import 'package:my_tasks/my_tasks/ui/my_tasks_page.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
@override
  void initState() {
    MainController().initMainApp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyTasksPage(),
    );
  }
}