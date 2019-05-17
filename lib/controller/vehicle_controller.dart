import 'package:aqueduct/aqueduct.dart';
import 'package:five_stars_server/body/vehicle_controller/vehicle_add.dart';
import 'package:five_stars_server/model/vehicle.dart';

class VehicleController extends ResourceController {
  VehicleController(this.context);

  final ManagedContext context;  

  @Operation.get()
  Future<Response> getAllVehicles() async {
    final query = Query<Vehicle>(context);
    final vehicles = await query.fetch();

    return Response.ok(vehicles);
  }

  @Operation.post()
  Future<Response> addVehicle() async {
    final body = AddVehicleObject()..read(await request.body.decode());

    final Vehicle vehicle = Vehicle.fromData(data: body);
    final Vehicle insertedVehicle = await context.insertObject(vehicle); 

    return Response.ok(insertedVehicle);
  }
}