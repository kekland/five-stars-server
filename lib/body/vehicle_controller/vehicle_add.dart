import 'package:aqueduct/aqueduct.dart';
import 'package:five_stars_server/model/shared.dart';

class AddVehicleObject extends Serializable {
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
  void readFromMap(Map<String, dynamic> object) {
    try {
      final List<String> reasons = [];

      if (object['departure'] == null) reasons.add('departure must not be null');
      if (object['arrival'] == null) reasons.add('arrival must not be null');
      if (object['weight'] == null) reasons.add('weight must not be null');
      if (object['volume'] == null) reasons.add('volume must not be null');
      if (object['vehicleType'] == null) reasons.add('vehicleType must not be null');

      if (reasons.isNotEmpty) {
        throw SerializableException(reasons);
      }

      departure = Location()..readFromMap(object['departure'] as Map<String, dynamic>);
      arrival = Location()..readFromMap(object['arrival'] as Map<String, dynamic>);
      weight = object['weight'] as double;
      volume = object['volume'] as double;
      vehicleType = vehicleTypeStrings[object['vehicleType']];
    } catch (error) {
      throw SerializableException([error.toString()]);
    }
  }
}
