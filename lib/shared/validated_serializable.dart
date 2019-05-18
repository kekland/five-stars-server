import 'package:aqueduct/aqueduct.dart';

abstract class ValidatedSerializable extends Serializable {
  @override
  void readFromMap(Map<String, dynamic> object) {
    if (keysToCheck != null) {
      final List<String> reasons = [];
      for (String key in keysToCheck) {
        if (object[key] == null) {
          reasons.add("${key} must not be null.");
        }
      }
      if (reasons.isNotEmpty) {
        throw SerializableException(reasons);
      }
    }

    try {
      readFromMapSerialized(object);
    } catch (err) {
      throw SerializableException([err.toString()]);
    }
  }

  List<String> get keysToCheck;
  void readFromMapSerialized(Map<String, dynamic> object);
}
