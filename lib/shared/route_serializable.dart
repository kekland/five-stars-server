import 'package:aqueduct/aqueduct.dart';
import 'package:five_stars_server/shared/validated_serializable.dart';

abstract class RequestSerializable extends ValidatedSerializable {
  @override
  Map<String, dynamic> asMap() => {};
}

abstract class ResponseSerializable extends Serializable {
  @override
  void readFromMap(Map<String, dynamic> object) {}
}