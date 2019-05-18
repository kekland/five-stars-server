import 'package:aqueduct/aqueduct.dart';

class Utils {
  static void validateLatitudeLongitudePair({double latitude, double longitude}) {
    final List<String> reasons = [];
    if (!(latitude >= -90.0 && latitude <= 90.0)) {
      reasons.add("latitude is not a valid geographical latitude");
    }
    if (!(longitude >= -180.0 && longitude <= 180.0)) {
      reasons.add("longitude is not a valid geographical longitude");
    }

    if (reasons.isNotEmpty) {
      throw SerializableException(reasons);
    }
  }

  static RegExp phoneNumber = RegExp('^[+]*[(]{0,1}[0-9]{1,3}[)]{0,1}[-\s\.\/0-9]*\$');

  static bool isPhoneNumber(String value) {
    return phoneNumber.hasMatch(value);
  }
}