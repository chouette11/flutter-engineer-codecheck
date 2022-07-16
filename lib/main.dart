import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_engineer_codecheck/home/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //向き指定(縦)
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then((_) => runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}
