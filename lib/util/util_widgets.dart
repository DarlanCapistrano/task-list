import 'package:flutter/material.dart';

class UtilWidget {
  static Widget loadingWidget(){
    return const Center(
      child: SizedBox(
        height: 25,
        width: 25,
        child: CircularProgressIndicator(color: Colors.red),
      ),
    );
  }
}