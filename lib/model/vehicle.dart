import 'package:aqueduct/aqueduct.dart';
import 'package:five_stars_server/body/vehicle_controller/vehicle_alter.dart';
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

  DateTime createdAt;
  DateTime updatedAt;
}

class Vehicle extends ManagedObject<_Vehicle> implements _Vehicle {
  Vehicle();

  Vehicle.fromData({AlterVehicleRequestObject data}) {
    arrivalLocation = data.arrival;
    departureLocation = data.departure;
    weight = data.weight;
    volume = data.volume;
    vehicleType = data.vehicleType;
  }

  @override
  void willUpdate() {
    updatedAt = DateTime.now().toUtc();
  }

  @override
  void willInsert() {
    createdAt = DateTime.now().toUtc();
  }

  Location get departureLocation =>
      Location(latitude: departureLatitude, longitude: departureLongitude, name: departureLocationName);

  Location get arrivalLocation =>
      Location(latitude: arrivalLatitude, longitude: arrivalLongitude, name: arrivalLocationName);

  set departureLocation(Location newLocation) {
    if(newLocation == null) return;
    departureLatitude = newLocation.latitude;
    departureLongitude = newLocation.longitude;
    departureLocationName = newLocation.name;
  }

  set arrivalLocation(Location newLocation) {
    if(newLocation == null) return;
    arrivalLatitude = newLocation.latitude;
    arrivalLongitude = newLocation.longitude;
    arrivalLocationName = newLocation.name;
  }
}
