import 'package:aqueduct/aqueduct.dart';
import 'package:five_stars_server/body/vehicle_controller/vehicle_alter.dart';
import 'package:five_stars_server/model/vehicle.dart';

class VehicleController extends ResourceController {
  VehicleController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllVehicles() async {
    final query = Query<Vehicle>(context);
    final vehicles = await query.fetch();
    final List<AlterVehicleResponseObject> response =
        vehicles.map((vehicle) => AlterVehicleResponseObject.fromVehicle(vehicle)).toList();

    return Response.ok(response);
  }

  @Operation.post()
  Future<Response> addVehicle(@Bind.body() AlterVehicleRequestObject body) async {
    final Vehicle vehicle = Vehicle.fromData(data: body);
    final Vehicle insertedVehicle = await context.insertObject(vehicle);

    return Response.ok(AlterVehicleResponseObject.fromVehicle(insertedVehicle));
  }

  @Operation.put('id')
  Future<Response> editVehicle(@Bind.path('id') int id, @Bind.body() AlterVehicleRequestObject body) async {
    final query = Query<Vehicle>(context)
      ..where((v) => v.id).equalTo(id)
      ..values = Vehicle.fromData(data: body);

    final updatedVehicle = await query.updateOne();

    if(updatedVehicle == null) {
      return Response.notFound(body: {"error": "not-found"});
    }

    return Response.ok(AlterVehicleResponseObject.fromVehicle(updatedVehicle));
  }

  @Operation.delete('id')
  Future<Response> deleteVehicle(@Bind.path('id') int id) async {
    final query = Query<Vehicle>(context)
      ..where((v) => v.id).equalTo(id);

    final deletedVehicleCount = await query.delete();

    if(deletedVehicleCount == 0) {
      return Response.notFound(body: {"error": "not-found"});
    }

    return Response.ok({"deleted": deletedVehicleCount});
  }
}
