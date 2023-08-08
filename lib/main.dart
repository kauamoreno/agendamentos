import 'package:flutter/material.dart';
import 'package:agendamentos/views/TelaLogin.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.red),
    home: TelaLogin(),
    debugShowCheckedModeBanner: false,
  ));
}
