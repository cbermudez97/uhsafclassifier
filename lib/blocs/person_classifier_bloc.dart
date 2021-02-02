import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safclassifier/models/models.dart';

class PersonClassifierBloc
    extends Bloc<PersonClassificatorEvent, PersonClassificatorState> {
  Dio dio;

  PersonClassifierBloc(String baseUrl) {
    var options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: {'Content-Type': 'application/json'});
    this.dio = Dio(options);

    this.dio.interceptors.add(InterceptorsWrapper(
      onResponse: (e) {
        e.data = e.data is String ? jsonDecode(e.data) : e.data;
        return e;
      },
    ));
  }

  @override
  get initialState => InitialPersonClassificatorState();

  @override
  Stream<PersonClassificatorState> mapEventToState(event) async* {
    if (event is LoadPersonClassificatorEvent) {
      yield LoadingPersonClassificatorState();

      //Update Previous
      if (event.previousModel != null) {
        try {
          var response = await this.dio.put(
            '/api/v1/classify/${event.previousModel.id}',
            data: {
              'tags': event.previousModel.causesTags,
              'others': event.previousModel.causesOthers,
            },
          );
        } on DioError catch (e) {
          print(e.message);
        }
      }

      //Load Next Model
      try {
        var response =
            await this.dio.get<Map<String, dynamic>>('/api/v1/empty');

        var data = response.data;

        yield LoadedPersonClassificatorState(PersonModel.fromJson(data));
      } on DioError catch (e) {
        print(e.message);
        if (e.response.statusCode == 404) {
          yield SucessPersonClassificatorState();
        } else {
          yield InitialPersonClassificatorState();
        }
      } catch (e) {
        print(e);
        yield InitialPersonClassificatorState();
      }
    } else
      yield InitialPersonClassificatorState();
  }
}

//EVENTS
abstract class PersonClassificatorEvent extends Equatable {
  const PersonClassificatorEvent();

  @override
  List<Object> get props => [];
}

class LoadPersonClassificatorEvent extends PersonClassificatorEvent {
  final PersonModel previousModel;

  const LoadPersonClassificatorEvent({this.previousModel});
}

//STATES
abstract class PersonClassificatorState extends Equatable {
  const PersonClassificatorState();

  @override
  List<Object> get props => [];
}

class InitialPersonClassificatorState extends PersonClassificatorState {}

class LoadingPersonClassificatorState extends PersonClassificatorState {}

class LoadedPersonClassificatorState extends PersonClassificatorState {
  final PersonModel person;

  const LoadedPersonClassificatorState(this.person);
}

class SucessPersonClassificatorState extends PersonClassificatorState {}
