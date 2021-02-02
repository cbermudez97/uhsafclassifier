import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safclassifier/blocs.dart';
import 'package:safclassifier/models/models.dart';

class PersonEditor extends StatefulWidget {
  @override
  PersonEditorState createState() => PersonEditorState();
}

class PersonEditorState extends State<PersonEditor> {
  PersonModel personModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonClassifierBloc, PersonClassifierState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadedPersonClassifierState) {
          personModel = state.person;
          log('Loaded ${personModel.fullName}');
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: RaisedButton(
                  child: Text('Siguiente'),
                  onPressed: () {
                    context.bloc<PersonClassifierBloc>().add(
                          LoadPersonClassifierEvent(
                            previousModel: personModel,
                          ),
                        );
                  },
                ),
              )
            ],
          );
        }
        if (state is LoadingPersonClassifierState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container();
      },
    );
  }
}
