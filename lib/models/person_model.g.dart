// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonModel _$PersonModelFromJson(Map<String, dynamic> json) {
  return PersonModel(
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    municipality: json['municipality'] as String,
    saf: json['saf'] as String,
    fullName: json['full_name'] as String,
    ci: json['ci'] as String,
    direction: json['direction'] as String,
    attendDaily: json['attend_daily'] as bool,
    attendRegular: json['attend_regular'] as bool,
    attendOcasional: json['attend_ocasional'] as bool,
    dontAttend: json['dont_attend'] as bool,
    serviceQualHigh: json['service_qual_high'] as bool,
    serviceQualMedium: json['service_qual_medium'] as bool,
    serviceQualLow: json['service_qual_low'] as bool,
    satisfactionGood: json['satisfaction_good'] as bool,
    satisfactionRegular: json['satisfaction_regular'] as bool,
    satisfactionBad: json['satisfaction_bad'] as bool,
    opinions: json['opinions'] as String,
    causes: json['causes'] as String,
    observations: json['observations'] as String,
    causesTags: (json['causes_tags'] as List)
        ?.map((e) => _$enumDecodeNullable(_$CausesTagsEnumMap, e))
        ?.toList(),
    causesOthers: json['causes_others'] as String,
  );
}

Map<String, dynamic> _$PersonModelToJson(PersonModel instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'municipality': instance.municipality,
      'saf': instance.saf,
      'full_name': instance.fullName,
      'ci': instance.ci,
      'direction': instance.direction,
      'attend_daily': instance.attendDaily,
      'attend_regular': instance.attendRegular,
      'attend_ocasional': instance.attendOcasional,
      'dont_attend': instance.dontAttend,
      'service_qual_high': instance.serviceQualHigh,
      'service_qual_medium': instance.serviceQualMedium,
      'service_qual_low': instance.serviceQualLow,
      'satisfaction_good': instance.satisfactionGood,
      'satisfaction_regular': instance.satisfactionRegular,
      'satisfaction_bad': instance.satisfactionBad,
      'opinions': instance.opinions,
      'causes': instance.causes,
      'observations': instance.observations,
      'causes_tags':
          instance.causesTags?.map((e) => _$CausesTagsEnumMap[e])?.toList(),
      'causes_others': instance.causesOthers,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$CausesTagsEnumMap = {
  CausesTags.Quantity: 'causes_quantity',
  CausesTags.Deceased: 'causes_deceased',
  CausesTags.Distance: 'causes_distance',
  CausesTags.LowQuality: 'causes_low_quality',
  CausesTags.Price: 'causes_price',
};
