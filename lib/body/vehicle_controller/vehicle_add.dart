import 'package:aqueduct/aqueduct.dart';
import 'package:five_stars_server/model/shared.dart';
import 'package:five_stars_server/shared/validated_serializable.dart';

class AddVehicleObject extends ValidatedSerializable {
  Location departure;
  Location arrival;
  double weight;
  double volume;

  VehicleType vehicleType;

  @override
  Map<String, dynamic> asMap() {
    return {
      'departure': departure.asMap(),
      'arrival': arrival.asMap(),
      'weight': weight,
      'volume': volume,
      'vehicleType': vehicleType,
    };
  }

  @override
  List<String> get keysToCheck => ['departure', 'arrival', 'weight', 'volume', 'vehicleType'];

  @override
  void readFromMapSerialized(Map<String, dynamic> object) {
    departure = Location()..readFromMap(object['departure'] as Map<String, dynamic>);
    arrival = Location()..readFromMap(object['arrival'] as Map<String, dynamic>);
    weight = object['weight'] as double;
    volume = object['volume'] as double;
    vehicleType = vehicleTypeStrings[object['vehicleType']];
  }
}
