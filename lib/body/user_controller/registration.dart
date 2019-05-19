import 'package:aqueduct/aqueduct.dart';
import 'package:five_stars_server/model/user.dart';
import 'package:five_stars_server/shared/route_serializable.dart';
import 'package:five_stars_server/shared/utils.dart';
import 'package:validators/validators.dart' as Validators;

class RegistrationRequestObject extends RequestSerializable {
  String username;
  String password;
  String email;
  String phoneNumber;

  String firstName;
  String middleName;
  String lastName;

  String organization;

  @override
  List<String> get keysToCheck =>
      ['username', 'password', 'email', 'phoneNumber', 'firstName', 'middleName', 'lastName', 'organization'];

  @override
  void readFromMapSerialized(Map<String, dynamic> object) {
    username = object['username'] as String;
    password = object['password'] as String;
    email = object['email'] as String;
    phoneNumber = object['phoneNumber'] as String;
    firstName = object['firstName'] as String;
    middleName = object['middleName'] as String;
    lastName = object['lastName'] as String;
    organization = object['organization'] as String;

    List<String> reasons = [];
    if (username.length < 6) {
      reasons.add('username must be longer than 6 characters.');
    }
    if (password.length < 6) {
      reasons.add('password must be longer than 6 characters.');
    }
    if (!Validators.isEmail(email)) {
      reasons.add('invalid email address.');
    }
    if (!Utils.isPhoneNumber(phoneNumber)) {
      reasons.add('invalid phone number.');
    }

    if (reasons.isNotEmpty) {
      throw SerializableException(reasons);
    }
  }
}

class RegistrationResponseObject extends ResponseSerializable {
  RegistrationResponseObject.fromUser(User user) {
    id = user.id;
    username = user.username;
    email = user.email;
    phoneNumber = user.phoneNumber;
    firstName = user.firstName;
    middleName = user.middleName;
    lastName = user.lastName;
    organization = user.organization;
  }

  int id;
  String username;
  String email;
  String phoneNumber;

  String firstName;
  String middleName;
  String lastName;

  String organization;

  @override
  Map<String, dynamic> asMap() {
    return {
      "id": id,
      "email": email,
      "username": username,
      "phoneNumber": phoneNumber,
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "organization": organization,
    };
  }
}
