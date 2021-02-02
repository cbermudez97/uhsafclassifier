import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safclassifier/blocs.dart';
import 'package:safclassifier/models/models.dart';

class PersonEditor extends StatefulWidget {
  @override
  _PersonEditorState createState() => _PersonEditorState();
}

class _PersonEditorState extends State<PersonEditor> {
  PersonModel personModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonClassifierBloc, PersonClassificatorState>(
      builder: (context, state) {
        if (state is InitialPersonClassificatorState) {
          context.bloc<PersonClassifierBloc>().add(LoadPersonClassificatorEvent(
                previousModel: personModel,
              ));
        }
        if (state is LoadedPersonClassificatorState) {
          personModel = state.person;
          print('Loaded ${personModel.fullName}');
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: RaisedButton(
                  child: Text('Siguiente'),
                  onPressed: () {
                    context
                        .bloc<PersonClassifierBloc>()
                        .add(LoadPersonClassificatorEvent(
                          previousModel: personModel,
                        ));
                  },
                ),
              )
            ],
          );
        }
        if (state is LoadingPersonClassificatorState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container();
      },
    );
  }
}
