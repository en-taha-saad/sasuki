import 'package:flutter/material.dart';
import 'package:sasuki/app/app_inits_funs/my_app.dart';
import 'package:sasuki/app/shared_funs/pre_init_app.dart';

void main() async {
  await preRun();
  //
  runApp(MyApp());
}
