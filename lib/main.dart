import 'package:flutter_application_1/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/SupabaseServices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService().initialize();
  runApp(MaterialApp(home: App()));
}
