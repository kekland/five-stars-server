import 'package:aqueduct/aqueduct.dart';
import 'package:five_stars_server/model/shared.dart';

class _Vehicle {
  @primaryKey
  int id;

  double departureLatitude;
  double departureLongitude;
  String departureLocationName;

  double arrivalLatitude;
  double arrivalLongitude;
  String arrivalLocationName;

  double weight;
  double volume;

  VehicleType vehicleType;
}

class Vehicle extends ManagedObject<_Vehicle> implements _Vehicle {
  Location get departureLocation =>
      Location(latitude: departureLatitude, longitude: departureLongitude, name: departureLocationName);

  Location get arrivalLocation =>
      Location(latitude: arrivalLatitude, longitude: arrivalLongitude, name: arrivalLocationName);

  set departureLocation(Location newLocation) {
    departureLatitude = newLocation.latitude;
    departureLongitude = newLocation.longitude;
    departureLocationName = newLocation.name;
  }

  set arrivalLocation(Location newLocation) {
    arrivalLatitude = newLocation.latitude;
    arrivalLongitude = newLocation.longitude;
    arrivalLocationName = newLocation.name;
  }
}