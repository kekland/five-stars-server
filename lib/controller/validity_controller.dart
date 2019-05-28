import 'package:aqueduct/aqueduct.dart';
import 'package:five_stars_server/body/user_controller/validity.dart';
import 'package:five_stars_server/model/user.dart';

class ValidityController extends ResourceController {
  ValidityController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.post()
  Future<Response> canUserBeCreated(@Bind.body() ValidityRequestObject data) async {
    final username = await (Query<User>(context)..where((u) => u.username).equalTo(data.username)).fetchOne();
    final email = await (Query<User>(context)..where((u) => u.email).equalTo(data.email)).fetchOne();
    final phoneNumber = await (Query<User>(context)..where((u) => u.phoneNumber).equalTo(data.phoneNumber)).fetchOne();
    return Response.ok(ValidityResponseObject(
      usernameAvailable: username == null,
      emailAvailable: email == null,
      phoneNumberAvailable: phoneNumber == null,
    ));
  }
}
