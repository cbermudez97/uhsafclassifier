import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safclassifier/blocs.dart';
import 'package:safclassifier/models/models.dart';
import 'package:safclassifier/widgets/widgets.dart';

class PersonEditor extends StatefulWidget {
  @override
  PersonEditorState createState() => PersonEditorState();
}

class PersonEditorState extends State<PersonEditor> {
  final controller = TextEditingController();
  PersonModel personModel;
  List<bool> selected = List.generate(CausesTags.values.length, (_) => false);

  @override
  void initState() {
    selected = List.generate(CausesTags.values.length, (_) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonClassifierBloc, PersonClassifierState>(
      listener: (context, state) {
        if (state is SuccessPersonClassifierState) {
          final snackBar = SnackBar(
            content: Text('Persona clasificada satisfactoriamente'),
          );
          Scaffold.of(context).showSnackBar(snackBar);
          selected = List.generate(CausesTags.values.length, (_) => false);
          controller.text = "";
        }
      },
      builder: (context, state) {
        if (state is LoadingPersonClassifierState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ErrorPersonClassifierState) {
          return Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    state.message,
                    style: Theme.of(context).primaryTextTheme.headline6,
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
                            child: Text('Reintentar'),
                          ),
                          onPressed: () async {
                            context.bloc<PersonClassifierBloc>().add(
                                  LoadPersonClassifierEvent(
                                    previousModel: personModel,
                                  ),
                                );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        if (state is FinishPersonClassifierState) {
          return Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Ya todas las peronas se encuentras clasificadas',
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
            ),
          );
        }
        if (state is LoadedPersonClassifierState) {
          personModel = state.person;
          log('Loaded ${personModel.fullName}');
          return ListView(
            children: [
              Card(
                margin: EdgeInsets.all(10),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nombre: ${state.person.fullName}'),
                      Text('CI: ${state.person.ci}'),
                      Text('SAF: ${state.person.saf}'),
                      Text('Fecha: ${state.person.date.toStr()}'),
                      Builder(
                        builder: (context) {
                          var message = "Asiste al SAF: No asiste";
                          if (state.person.attendDaily) {
                            message = "Asiste al SAF: Diariamente";
                          } else if (state.person.attendRegular) {
                            message = "Asiste al SAF: Regularmente";
                          } else if (state.person.attendOcasional) {
                            message = "Asiste al SAF: Ocasionalmente";
                          }
                          return Text(message);
                        },
                      ),
                      Builder(
                        builder: (context) {
                          var message = "Nivel de satisfacción: Bajo";
                          if (state.person.satisfactionGood) {
                            message = "Nivel de satisfacción: Alto";
                          } else if (state.person.satisfactionRegular) {
                            message = "Nivel de satisfacción: Medio";
                          }
                          return Text(message);
                        },
                      ),
                      Builder(
                        builder: (context) {
                          var message = "Calidad del servicio: Malo";
                          if (state.person.serviceQualHigh) {
                            message = "Calidad del servicio: Bueno";
                          } else if (state.person.serviceQualMedium) {
                            message = "Calidad del servicio: Regular";
                          }
                          return Text(message);
                        },
                      ),
                      Text('Opiniones: ${state.person.opinions}'),
                      Text('Causas: ${state.person.causes}'),
                      Text('Observaciones: ${state.person.observations}'),
                    ],
                  ),
                ),
              ),
              Divider(),
              for (var i = 0; i < CausesTags.values.length; ++i)
                CheckboxListTile(
                  title: Text(CausesTags.values[i].toStr()),
                  value: selected[i],
                  dense: true,
                  onChanged: (bool value) {
                    setState(() {
                      selected[i] = value;
                    });
                  },
                ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SAFTextField(
                  label: 'Otros',
                  minLines: 2,
                  maxLines: 10,
                  controller: controller,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                          child: Text('Guardar'),
                        ),
                        onPressed: () async {
                          personModel.causesTags =
                              List.generate(selected.length, (i) => i)
                                  .where((i) => selected[i])
                                  .map((i) => CausesTags.values[i])
                                  .toList();
                          log(personModel.causesTags.toString());
                          personModel.causesOthers = controller.text.trim();
                          context.bloc<PersonClassifierBloc>().add(
                                LoadPersonClassifierEvent(
                                  previousModel: personModel,
                                ),
                              );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
