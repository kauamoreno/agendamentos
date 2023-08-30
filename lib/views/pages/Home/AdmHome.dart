import 'package:agendamentos/views/components/CustomAppBar.dart';
import 'package:flutter/material.dart';

class AdmHome extends StatefulWidget {
  const AdmHome({Key? key}) : super(key: key);

  @override
  State<AdmHome> createState() => _AdmHomeState();
}

class _AdmHomeState extends State<AdmHome> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titulo: 'Perfil'),
      body: Center(
        child: Text('ADM'),
      
      ),
    );
  }
}
