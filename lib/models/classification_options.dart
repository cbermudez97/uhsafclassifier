import 'package:json_annotation/json_annotation.dart';

extension CausesTagsExt on CausesTags {
  String toStr() {
    switch(this) {
      case CausesTags.Quantity:
        // TODO: Handle this case.
        break;
      case CausesTags.Deceased:
        // TODO: Handle this case.
        break;
      case CausesTags.Distance:
        // TODO: Handle this case.
        break;
      case CausesTags.LowQuality:
        // TODO: Handle this case.
        break;
      case CausesTags.Price:
        // TODO: Handle this case.
        break;
      case CausesTags.NoDir:
        // TODO: Handle this case.
        break;
    }
  }
}

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
  @JsonValue('causes_no_dir')
  NoDir
}
