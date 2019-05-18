import 'package:five_stars_server/controller/cargo_controller.dart';
import 'package:five_stars_server/controller/vehicle_controller.dart';

import 'five_stars_server.dart';

class MyConfiguration extends Configuration {
  MyConfiguration(File file) : super.fromFile(file);

  DatabaseConfiguration database;
}

class FiveStarsServerChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    final config = MyConfiguration(File("./postgres.yaml"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();

    final psc = PostgreSQLPersistentStore(config.database.username, config.database.password,
        config.database.host, config.database.port, config.database.databaseName);

    context = ManagedContext(dataModel, psc);

    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
      .route('vehicle/[:id]')
      .link(() => VehicleController(context));

    router
      .route('cargo/[:id]')
      .link(() => CargoController(context));


    return router;
  }
}
