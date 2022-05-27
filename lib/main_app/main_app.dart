import 'package:flutter/material.dart';
import 'package:my_tasks/my_tasks/ui/my_tasks_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyTasksPage(),
    );
  }
}