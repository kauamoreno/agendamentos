import 'package:flutter/material.dart';
import '../services/Autenticacao.dart';
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
                child: const Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'AGS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                  ]
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.55,
                decoration: const BoxDecoration(
                  color: Color(0xFFB71835),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        textFieldComponent.textFieldEmail(label: "Email", hint: 'email@mail.com', controller: _emailController),
                        textFieldComponent.textFieldSenha(label: "Senha", hint: '', controller: _senhaController),

                        ElevatedButton(
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
