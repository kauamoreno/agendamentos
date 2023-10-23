import 'package:agendamentos/views/components/inputs.dart';
import 'package:flutter/material.dart';
import '../../models/services/Autenticacao.dart';
import '../components/TextFieldComponent.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  @override
  void initState() {
    super.initState();
  }

  TextFieldComponent textFieldComponent = TextFieldComponent();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,

        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,

          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.4,
                alignment: const AlignmentDirectional(0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/agslogo.png', height: MediaQuery.sizeOf(context).height * 0.35,)
                  ]
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.55,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Input(titulo: 'Email', dica: 'email@mail.com', controller: _emailController,),
                        Input(titulo: 'Senha', dica: '', controller: _senhaController,),

                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: ElevatedButton(
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Entrar',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            onPressed: () {
                              Autenticacao().fazerLogin(
                                email: _emailController.text, 
                                senha: _senhaController.text, 
                                context: context
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
