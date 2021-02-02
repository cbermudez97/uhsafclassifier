import 'package:json_annotation/json_annotation.dart';

import 'package:safclassifier/models/classification_options.dart';

part 'person_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PersonModel {
  int id;
  DateTime date;
  String municipality;
  String saf;
  @JsonKey(name: 'full_name')
  String fullName;
  String ci;
  String direction;
  @JsonKey(name: 'attend_daily')
  bool attendDaily;
  @JsonKey(name: 'attend_regular')
  bool attendRegular;
  @JsonKey(name: 'attend_ocasional')
  bool attendOcasional;
  @JsonKey(name: 'dont_attend')
  bool dontAttend;
  @JsonKey(name: 'service_qual_high')
  bool serviceQualHigh;
  @JsonKey(name: 'service_qual_medium')
  bool serviceQualMedium;
  @JsonKey(name: 'service_qual_low')
  bool serviceQualLow;
  @JsonKey(name: 'satisfaction_good')
  bool satisfactionGood;
  @JsonKey(name: 'satisfaction_regular')
  bool satisfactionRegular;
  @JsonKey(name: 'satisfaction_bad')
  bool satisfactionBad;
  String opinions;
  String causes;
  String observations;
  @JsonKey(name: 'causes_tags')
  List<CausesTags> causesTags;
  @JsonKey(name: 'causes_others')
  String causesOthers;

  PersonModel({
    this.id,
    this.date,
    this.municipality,
    this.saf,
    this.fullName,
    this.ci,
    this.direction,
    this.attendDaily,
    this.attendRegular,
    this.attendOcasional,
    this.dontAttend,
    this.serviceQualHigh,
    this.serviceQualMedium,
    this.serviceQualLow,
    this.satisfactionGood,
    this.satisfactionRegular,
    this.satisfactionBad,
    this.opinions,
    this.causes,
    this.observations,
    this.causesTags,
    this.causesOthers,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) =>
      _$PersonModelFromJson(json);

  Map<String, dynamic> toJson() => _$PersonModelToJson(this);
}
