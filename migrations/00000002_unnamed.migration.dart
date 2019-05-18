import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration2 extends Migration { 
  @override
  Future upgrade() async {
   		database.addColumn("_Vehicle", SchemaColumn("createdAt", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false), unencodedInitialValue: "'2019-05-18 10:23:54'");
		database.addColumn("_Vehicle", SchemaColumn("updatedAt", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false), unencodedInitialValue: "'2019-05-18 10:23:54'");
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    