import 'package:aqueduct/aqueduct.dart';
import 'package:five_stars_server/shared/utils.dart';
import 'package:five_stars_server/shared/validated_serializable.dart';

class Location extends ValidatedSerializable {
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
  List<String> get keysToCheck => ['latitude', 'longitude', 'name'];

  @override
  void readFromMapSerialized(Map<String, dynamic> object) {
    latitude = object['latitude'] as double;
    longitude = object['longitude'] as double;
    name = object['name'] as String;

    Utils.validateLatitudeLongitudePair(latitude: latitude, longitude: longitude);
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

class VehicleTypeUtils {
  static Map<String, VehicleType> vehicleTypeStrings = {
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
  static VehicleType stringToVehicleType(String value) => vehicleTypeStrings[value];
  static String vehicleTypeToString(VehicleType value) => value.toString().split('.').last;
}
