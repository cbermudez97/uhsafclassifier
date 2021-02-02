import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safclassifier/blocs.dart';

import 'widgets/person_editor.dart';

class PersonClassifierView extends StatefulWidget {
  final String host;

  const PersonClassifierView({Key key, this.host}) : super(key: key);

  @override
  _PersonClassifierViewState createState() => _PersonClassifierViewState(host);
}

class _PersonClassifierViewState extends State<PersonClassifierView> {
  final String host;

  _PersonClassifierViewState(this.host);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocProvider<PersonClassifierBloc>(
            create: (_) => PersonClassifierBloc(host),
            child: PersonEditor(),
          )
        ],
      ),
    );
  }
}
