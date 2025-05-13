import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class ScreenDetail extends StatefulWidget {
  final String data;
  const ScreenDetail({super.key, required this.data});

  @override
  State<ScreenDetail> createState() => _ScreenDetailState();
  void onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute('ALTER TABLE Coffe ADD COLUMN nama TEXT');
    }
  }
}

class _ScreenDetailState extends State<ScreenDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.asset(
          widget.data,
        ),
      ),
    );
  }
}
