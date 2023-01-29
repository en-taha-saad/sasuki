import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sasuki/app/http_client.dart';
import 'package:sasuki/app/init_screens_dependencies/init_app_module.dart';

preRun() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
}
