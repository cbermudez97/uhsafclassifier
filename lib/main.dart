import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:safclassifier/views/person_classifier_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:safclassifier/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();

  runApp(App(prefs: prefs));
}

class App extends StatelessWidget {
  final SharedPreferences prefs;

  const App({Key key, this.prefs}) : super(key: key);

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
      home: HomePage(
        title: 'Clasificador SAF',
        prefs: prefs,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  final keyForm = GlobalKey<FormState>();
  final controller = TextEditingController();
  final SharedPreferences prefs;
  final String keyHost = 'previous-url';

  HomePage({
    Key key,
    this.title,
    this.prefs,
  }) : super(key: key) {
    if (prefs.containsKey(keyHost)) {
      controller.text = prefs.getString(keyHost);
    }
  }

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
                            prefs.setString(keyHost, controller.text);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => PersonClassifierView(
                                  title: title,
                                  host: controller.text.trim(),
                                ),
                              ),
                            );
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
