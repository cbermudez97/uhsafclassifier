import 'package:json_annotation/json_annotation.dart';

extension CausesTagsExt on CausesTags {
  String toStr() {
    switch (this) {
      case CausesTags.Quantity:
        return 'Poca cantidad de los alimentos';
        break;
      case CausesTags.Deceased:
        return 'Fallecido';
        break;
      case CausesTags.Distance:
        return 'Lejanía del SAF';
        break;
      case CausesTags.LowQuality:
        return 'Mala calidad de los alimentos';
        break;
      case CausesTags.Price:
        return 'Precios';
        break;
      case CausesTags.NoDir:
        return 'No se encuentra en esa dirección';
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
