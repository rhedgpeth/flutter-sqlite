import 'package:rolodex/models/base_model.dart';

class Contact extends BaseModel {
  late String _firstName;
  late String _lastName;
  late String _phone;
  late String _email;

  Contact(this._firstName, this._lastName, this._phone, this._email);

  Contact.map(dynamic obj) {
    setId(obj["id"]);
    _firstName = obj["firstName"];
    _lastName = obj["lastName"];
    _phone = obj["phone"];
    _email = obj["email"];
  }

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get phone => _phone;
  String get email => _email;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map["firstname"] = _firstName;
    map["lastname"] = _lastName;
    map["phone"] = _phone;
    map["email"] = _email;

    return map;
  }
}