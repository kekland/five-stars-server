
import 'package:aqueduct/aqueduct.dart';
import 'package:five_stars_server/body/user_controller/registration.dart';
import 'package:five_stars_server/model/user.dart';

class UserController extends ResourceController {
  UserController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.post()
  Future<Response> createUser(@Bind.body() RegistrationRequestObject user) async {
    final newUser = User.fromData(data: user);
    newUser.hashedPassword = authServer.hashPassword(user.password, newUser.salt);
    
    final insertedUser = await Query<User>(context, values: newUser).insert();

    return Response.ok(RegistrationResponseObject.fromUser(insertedUser));
  }
}