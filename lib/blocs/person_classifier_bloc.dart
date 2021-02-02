import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safclassifier/models/models.dart';

class PersonClassifierBloc
    extends Bloc<PersonClassifierEvent, PersonClassifierState> {
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
  get initialState => LoadingPersonClassifierState();

  @override
  Stream<PersonClassifierState> mapEventToState(event) async* {
    if (event is LoadPersonClassifierEvent) {
      yield LoadingPersonClassifierState();

      // Update Previous
      if (event.previousModel != null) {
        try {
          var data = event.previousModel.toJson();
          await this.dio.put(
            '/api/v1/classify/${event.previousModel.id}',
            data: {
              'tags': data['causes_tags'],
              'others': data['causes_others'],
            },
          );
          yield SuccessPersonClassifierState();
        } on DioError catch (e) {
          log(e.message);
        }
      }

      // Load Next Model
      try {
        var response = await this.dio.get<Map<String, dynamic>>('/api/v1/empty');
        var data = response.data;
        yield LoadedPersonClassifierState(PersonModel.fromJson(data));
      } on DioError catch (e) {
        log(e.message);
        if (e.response.statusCode == 404) {
          yield FinishPersonClassifierState();
        } else {
          yield ErrorPersonClassifierState(e.message);
        }
      } catch (e) {
        log(e.toString());
        yield ErrorPersonClassifierState(e.toString());
      }
    }
  }
}

// EVENTS
abstract class PersonClassifierEvent extends Equatable {
  const PersonClassifierEvent();

  @override
  List<Object> get props => [];
}

class LoadPersonClassifierEvent extends PersonClassifierEvent {
  final PersonModel previousModel;

  const LoadPersonClassifierEvent({this.previousModel});
}

// STATES
abstract class PersonClassifierState extends Equatable {
  const PersonClassifierState();

  @override
  List<Object> get props => [];
}

class LoadingPersonClassifierState extends PersonClassifierState {}

class LoadedPersonClassifierState extends PersonClassifierState {
  final PersonModel person;

  const LoadedPersonClassifierState(this.person);
}

class FinishPersonClassifierState extends PersonClassifierState {}

class SuccessPersonClassifierState extends LoadingPersonClassifierState {}

class ErrorPersonClassifierState extends PersonClassifierState {
  final String message;

  const ErrorPersonClassifierState(this.message);
}
