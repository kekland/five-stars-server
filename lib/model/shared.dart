import 'package:aqueduct/aqueduct.dart';

class Location extends Serializable {
  Location({this.latitude, this.longitude, this.name});

  double latitude;
  double longitude;

  String name;

  @override
  Map<String, dynamic> asMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    try {
      final List<String> reasons = [];

      if (object['latitude'] == null) reasons.add('latitude must not be null');
      if (object['longitude'] == null) reasons.add('longitude must not be null');
      if (object['name'] == null) reasons.add('name must not be null');

      if (reasons.isNotEmpty) {
        throw SerializableException(reasons);
      }

      latitude = object['latitude'] as double;
      longitude = object['longitude'] as double;
      name = object['name'] as String;
    } catch (error) {
      throw SerializableException([error.toString()]);
    }
  }
}

enum VehicleType {
  autoTransporter,
  onboard,
  jumbo,
  closed,
  isotherm,
  isothermRefrigerated,
  containerTransporter,
  mega,
  open,
  refrigerator,
  dumpTruck,
  tent,
  trawl,
  allMetal,
  curtain,
}

Map<String, VehicleType> vehicleTypeStrings = {
  "autoTransporter": VehicleType.autoTransporter,
  "onboard": VehicleType.onboard,
  "jumbo": VehicleType.jumbo,
  "closed": VehicleType.closed,
  "isotherm": VehicleType.isotherm,
  "isothermRefrigerated": VehicleType.isothermRefrigerated,
  "containerTransporter": VehicleType.containerTransporter,
  "mega": VehicleType.mega,
  "open": VehicleType.open,
  "refrigerator": VehicleType.refrigerator,
  "dumpTruck": VehicleType.dumpTruck,
  "tent": VehicleType.tent,
  "trawl": VehicleType.trawl,
  "allMetal": VehicleType.allMetal,
  "curtain": VehicleType.curtain,
};