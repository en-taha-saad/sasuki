import 'package:flutter/material.dart';
import 'package:sasuki/app/my_app.dart';
import 'package:sasuki/app/functions/pre_init_app.dart';

void main() async {
  await preRun();
  runApp(MyApp());
}
