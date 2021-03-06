import 'package:aqueduct/aqueduct.dart';
import 'package:five_stars_server/body/user_controller/registration.dart';
import 'package:five_stars_server/model/shared.dart';
import 'package:five_stars_server/model/vehicle.dart';
import 'package:five_stars_server/shared/route_serializable.dart';
import 'package:five_stars_server/shared/validated_serializable.dart';

class AlterVehicleRequestObject extends RequestSerializable {
  Location departure;
  Location arrival;
  double weight;
  double volume;

  VehicleType vehicleType;

  @override
  List<String> get keysToCheck => ['departure', 'arrival', 'weight', 'volume', 'vehicleType'];

  @override
  void readFromMapSerialized(Map<String, dynamic> object) {
    departure = Location()..readFromMap(object['departure'] as Map<String, dynamic>);
    arrival = Location()..readFromMap(object['arrival'] as Map<String, dynamic>);
    weight = object['weight'] as double;
    volume = object['volume'] as double;
    vehicleType = VehicleTypeUtils.stringToVehicleType(object['vehicleType'] as String);
  }
}

class AlterVehicleResponseObject extends ResponseSerializable {
  AlterVehicleResponseObject.fromVehicle(Vehicle vehicle) {
    id = vehicle.id;
    departure = vehicle.departureLocation;
    arrival = vehicle.arrivalLocation;
    weight = vehicle.weight;
    volume = vehicle.volume;
    vehicleType = vehicle.vehicleType;
    createdAt = vehicle.createdAt;
    updatedAt = vehicle.updatedAt;
    owner = RegistrationResponseObject.fromUser(vehicle.owner);
  }

  int id;
  Location departure;
  Location arrival;
  double weight;
  double volume;

  VehicleType vehicleType;
  DateTime createdAt;
  DateTime updatedAt;

  RegistrationResponseObject owner;

  @override
  Map<String, dynamic> asMap() {
    return {
      "id": id,
      "departure": departure.asMap(),
      "arrival": arrival.asMap(),
      "weight": weight,
      "volume": volume,
      "vehicleType": VehicleTypeUtils.vehicleTypeToString(vehicleType),
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "owner": owner.asMap(),
    };
  }
}