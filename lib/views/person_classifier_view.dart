import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safclassifier/blocs.dart';

import 'widgets/person_editor.dart';

class PersonClassifierView extends StatefulWidget {
  final String title;
  final String host;

  const PersonClassifierView({
    Key key,
    @required this.title,
    @required this.host,
  }) : super(key: key);

  @override
  PersonClassifierViewState createState() => PersonClassifierViewState();
}

class PersonClassifierViewState extends State<PersonClassifierView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: BlocProvider<PersonClassifierBloc>(
          create: (_) => PersonClassifierBloc(widget.host)
            ..add(
              LoadPersonClassifierEvent(),
            ),
          child: PersonEditor(),
        ),
      ),
    );
  }
}
