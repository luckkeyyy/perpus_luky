import 'package:flutter/material.dart';
import 'view/perpus_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/perpus',
      routes: {
        '/perpus': (context) => const PerpusView(),
      },
    );
  }
}
