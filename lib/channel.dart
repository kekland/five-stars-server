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
    final psc = PostgreSQLPersistentStore.fromConnectionInfo(config.database.username, config.database.password,
        config.database.host, config.database.port, config.database.databaseName);

    context = ManagedContext(dataModel, psc);

    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/example").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });

    return router;
  }
}
