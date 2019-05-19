import 'package:aqueduct/aqueduct.dart';
import 'package:five_stars_server/body/cargo_controller/cargo_alter.dart';
import 'package:five_stars_server/model/shared.dart';
import 'package:five_stars_server/model/user.dart';

class _Cargo {
  @primaryKey
  int id;

  DateTime departureTime;
  DateTime arrivalTime;

  double departureLatitude;
  double departureLongitude;
  String departureLocationName;

  double arrivalLatitude;
  double arrivalLongitude;
  String arrivalLocationName;

  double weight;
  double volume;
  double price;

  VehicleType vehicleType;

  DateTime createdAt;
  DateTime updatedAt;

  @Relate(#cargo)
  User owner;
}

class Cargo extends ManagedObject<_Cargo> implements _Cargo {
  Cargo();

  Cargo.fromData({AlterCargoRequestObject data}) {
    arrivalTime = data.arrivalTime;
    departureTime = data.departureTime;
    arrivalLocation = data.arrival;
    departureLocation = data.departure;
    weight = data.weight;
    volume = data.volume;
    price = data.price;
    vehicleType = data.vehicleType;
  }

  @override
  void willUpdate() {
    updatedAt = DateTime.now().toUtc();
  }

  @override
  void willInsert() {
    createdAt = DateTime.now().toUtc();
    updatedAt = DateTime.now().toUtc();
  }

  Location get departureLocation =>
      Location(latitude: departureLatitude, longitude: departureLongitude, name: departureLocationName);

  Location get arrivalLocation =>
      Location(latitude: arrivalLatitude, longitude: arrivalLongitude, name: arrivalLocationName);

  set departureLocation(Location newLocation) {
    if (newLocation == null) return;
    departureLatitude = newLocation.latitude;
    departureLongitude = newLocation.longitude;
    departureLocationName = newLocation.name;
  }

  set arrivalLocation(Location newLocation) {
    if (newLocation == null) return;
    arrivalLatitude = newLocation.latitude;
    arrivalLongitude = newLocation.longitude;
    arrivalLocationName = newLocation.name;
  }
}
