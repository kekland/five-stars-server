import 'package:aqueduct/aqueduct.dart';
import 'package:five_stars_server/model/cargo.dart';
import 'package:five_stars_server/model/shared.dart';
import 'package:five_stars_server/model/vehicle.dart';
import 'package:five_stars_server/shared/route_serializable.dart';
import 'package:five_stars_server/shared/validated_serializable.dart';

class AlterCargoRequestObject extends RequestSerializable {
  DateTime departureTime;
  DateTime arrivalTime;

  Location departure;
  Location arrival;

  double weight;
  double volume;
  double price;

  VehicleType vehicleType;

  @override
  List<String> get keysToCheck => ['departureTime', 'arrivalTime', 'departure', 'arrival', 'weight', 'volume', 'price', 'vehicleType'];

  @override
  void readFromMapSerialized(Map<String, dynamic> object) {
    departureTime = DateTime.parse(object['departureTime'] as String);
    arrivalTime = DateTime.parse(object['arrivalTime'] as String);
    departure = Location()..readFromMap(object['departure'] as Map<String, dynamic>);
    arrival = Location()..readFromMap(object['arrival'] as Map<String, dynamic>);
    weight = object['weight'] as double;
    volume = object['volume'] as double;
    price = object['price'] as double;
    vehicleType = VehicleTypeUtils.stringToVehicleType(object['vehicleType'] as String);
  }
}

class AlterCargoResponseObject extends ResponseSerializable {
  AlterCargoResponseObject.fromCargo(Cargo cargo) {
    id = cargo.id;
    departureTime = cargo.departureTime;
    arrivalTime = cargo.arrivalTime;

    departure = cargo.departureLocation;
    arrival = cargo.arrivalLocation;
    weight = cargo.weight;
    volume = cargo.volume;
    price = cargo.price;
    vehicleType = cargo.vehicleType;
    createdAt = cargo.createdAt;
    updatedAt = cargo.updatedAt;
  }

  int id;

  DateTime departureTime;
  DateTime arrivalTime;

  Location departure;
  Location arrival;

  double weight;
  double volume;
  double price;

  VehicleType vehicleType;
  DateTime createdAt;
  DateTime updatedAt;

  @override
  Map<String, dynamic> asMap() {
    return {
      "id": id,
      "departureTime": departureTime.toIso8601String(),
      "arrivalTime": arrivalTime.toIso8601String(),
      "departure": departure.asMap(),
      "arrival": arrival.asMap(),
      "weight": weight,
      "volume": volume,
      "price": price,
      "vehicleType": VehicleTypeUtils.vehicleTypeToString(vehicleType),
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}