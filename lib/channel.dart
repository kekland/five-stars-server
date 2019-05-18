import 'package:aqueduct/managed_auth.dart';
import 'package:five_stars_server/controller/cargo_controller.dart';
import 'package:five_stars_server/controller/user_controller.dart';
import 'package:five_stars_server/controller/vehicle_controller.dart';
import 'package:five_stars_server/model/user.dart';

import 'five_stars_server.dart';

class MyConfiguration extends Configuration {
  MyConfiguration(File file) : super.fromFile(file);

  DatabaseConfiguration database;
}

class FiveStarsServerChannel extends ApplicationChannel {
  ManagedContext context;
  AuthServer authServer;

  @override
  Future prepare() async {
    final config = MyConfiguration(File("./postgres.yaml"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();

    final psc = PostgreSQLPersistentStore(config.database.username, config.database.password, config.database.host,
        config.database.port, config.database.databaseName);

    context = ManagedContext(dataModel, psc);

    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final authStorage = ManagedAuthDelegate<User>(context);
    authServer = AuthServer(authStorage);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route('auth').link(() => AuthController(authServer));
    router.route('vehicle/[:id]')..link(() => Authorizer.bearer(authServer))..link(() => VehicleController(context));
    router.route('cargo/[:id]')..link(() => Authorizer.bearer(authServer))..link(() => CargoController(context));
    router.route('user').link(() => UserController(context, authServer));

    return router;
  }
}
