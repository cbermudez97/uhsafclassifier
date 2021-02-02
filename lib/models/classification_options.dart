import 'package:json_annotation/json_annotation.dart';

enum CausesTags {
  @JsonValue('causes_quantity')
  Quantity,
  @JsonValue('causes_deceased')
  Deceased,
  @JsonValue('causes_distance')
  Distance,
  @JsonValue('causes_low_quality')
  LowQuality,
  @JsonValue('causes_price')
  Price,
}
