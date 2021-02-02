import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:safclassifier/widgets/widgets.dart';

import 'views/person_clasifier_view.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clasificador SAF',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'GothamRounded',
      ),
      home: HomePage(title: 'Clasificador SAF'),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  final keyForm = GlobalKey<FormState>();
  final controller = TextEditingController();

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Form(
          key: keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Entre la dirección del servidor',
                  style: Theme.of(context).primaryTextTheme.headline6,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SAFTextField(
                  label: 'Servidor',
                  hint: 'http://localhost:8000',
                  controller: controller,
                  keyboardType: TextInputType.url,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El servidor es obligatorio';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          child: Text('Continuar'),
                        ),
                        onPressed: () async {
                          if (keyForm.currentState.validate()) {
                            log('Moving to new page with host=${controller.text}');
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (_) => PersonClassifierView(
                                          host: controller.text,
                                        )));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
