import 'package:aqueduct/managed_auth.dart';
import 'package:aqueduct/aqueduct.dart';
import 'package:five_stars_server/body/user_controller/registration.dart';
import 'package:five_stars_server/model/cargo.dart';
import 'package:five_stars_server/model/vehicle.dart';

class User extends ManagedObject<_User> implements _User, ManagedAuthResourceOwner<_User> {
  User();

  User.fromData({RegistrationRequestObject data}) {
    username = data.username;
    email = data.email;
    phoneNumber = data.phoneNumber;
    salt = AuthUtility.generateRandomSalt();
  }
}

class _User extends ResourceOwnerTableDefinition {
  @Column(indexed: true)
  String email;

  @Column(indexed: true)
  String phoneNumber;

  @Column(defaultValue: "false")
  bool confirmed;

  String firstName;
  String middleName;
  String lastName;
  
  String organization;

  ManagedSet<Cargo> cargo;
  ManagedSet<Vehicle> vehicles;
}
