import 'package:aqueduct/aqueduct.dart';
import 'package:five_stars_server/body/cargo_controller/cargo_alter.dart';
import 'package:five_stars_server/model/cargo.dart';

class CargoController extends ResourceController {
  CargoController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllCargo() async {
    final query = Query<Cargo>(context);
    final cargos = await query.fetch();
    final List<AlterCargoResponseObject> response =
        cargos.map((cargo) => AlterCargoResponseObject.fromCargo(cargo)).toList();

    print(cargos[0].owner);

    return Response.ok(response);
  }

  @Operation.post()
  Future<Response> addCargo(@Bind.body() AlterCargoRequestObject body) async {
    final Cargo cargo = Cargo.fromData(data: body);

    final query = Query<Cargo>(context)
      ..values = cargo
      ..values.owner.id = request.authorization.ownerID;

    final Cargo insertedCargo = await query.insert();

    return Response.ok(AlterCargoResponseObject.fromCargo(insertedCargo));
  }

  @Operation.put('id')
  Future<Response> editCargo(@Bind.path('id') int id, @Bind.body() AlterCargoRequestObject body) async {
    final query = Query<Cargo>(context)
      ..where((c) => c.id).equalTo(id)
      ..where((c) => c.owner).identifiedBy(request.authorization.ownerID)
      ..values = Cargo.fromData(data: body);

    final updatedCargo = await query.updateOne();

    if (updatedCargo == null) {
      return Response.notFound(body: {"error": "not-found"});
    }

    return Response.ok(AlterCargoResponseObject.fromCargo(updatedCargo));
  }

  @Operation.delete('id')
  Future<Response> deleteCargo(@Bind.path('id') int id) async {
    final query = Query<Cargo>(context)
      ..where((c) => c.id).equalTo(id)
      ..where((c) => c.owner).identifiedBy(request.authorization.ownerID);

    final deletedCargoCount = await query.delete();

    if (deletedCargoCount == 0) {
      return Response.notFound(body: {"error": "not-found"});
    }

    return Response.ok({"deleted": deletedCargoCount});
  }
}
