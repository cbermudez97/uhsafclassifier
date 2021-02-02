import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safclassifier/blocs.dart';

import 'widgets/person_editor.dart';

class PersonClassifierView extends StatefulWidget {
  final String host;

  const PersonClassifierView({Key key, @required this.host}) : super(key: key);

  @override
  PersonClassifierViewState createState() => PersonClassifierViewState(host);
}

class PersonClassifierViewState extends State<PersonClassifierView> {
  final String host;

  PersonClassifierViewState(this.host);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocProvider<PersonClassifierBloc>(
            create: (_) => PersonClassifierBloc(host)
              ..add(
                LoadPersonClassifierEvent(),
              ),
            child: PersonEditor(),
          ),
        ],
      ),
    );
  }
}
