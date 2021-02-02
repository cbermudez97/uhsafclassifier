import 'package:json_annotation/json_annotation.dart';

extension CausesTagsExt on CausesTags {
  String toStr() {
    switch (this) {
      case CausesTags.Quantity:
        return 'Poca cantidad de los alimentos';
      case CausesTags.Deceased:
        return 'Fallecido';
      case CausesTags.Distance:
        return 'Lejanía del SAF';
      case CausesTags.LowQuality:
        return 'Mala calidad de los alimentos';
      case CausesTags.Price:
        return 'Precios';
      case CausesTags.NoDir:
        return 'No se encuentra en esa dirección';
      default:
        return '';
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
