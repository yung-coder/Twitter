import 'package:flutter/material.dart';
import 'package:twitter/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: Scaffold(
        body: Text('Twiiter'),
      ),
    );
  }
}
