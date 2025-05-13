import 'package:flutter/material.dart';
import 'package:coffeshope/home.dart';
import 'package:coffeshope/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ScreenPageProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final prov = Provider.of<ScreenPageProvider>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.brown),
        home: const HomePage());
  }
}
