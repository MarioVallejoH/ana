import '../../utils/formating/data_formating.dart';

class UserModel {
  UserModel(
      {required this.email,
      required this.phone,
      required this.username,
      required this.firstName,
      required this.firstLastname,
      required this.password,
      this.active = 1,
      this.viewRight = 0,
      this.gender,
      this.company});

  String email;
  String phone;
  String username;
  String firstName;
  String password;
  String? company;
  String? gender;

  int active;
  int viewRight;

  String firstLastname;

  factory UserModel.fromJson(Map json) => UserModel(
        email: json["codigo_ciudad"],
        phone: json["phone"],
        username: json["username"],
        password: json["password"],
        firstName: json["first_name"],
        firstLastname: json["first_lastname"],
      );

  Map<String, dynamic> toJson({bool toVerify = false}) {
    if (toVerify) {
      return {"email": email, "phone": phone, "username": username};
    } else {
      return {
        "email": email,
        "phone": phone,
        "gender": gender,
        "company": company,
        "active": active,
        "view_right": viewRight,
        "username": username,
        "first_name": firstName,
        "last_name": firstLastname,
        "password": (password)
      };
    }
  }

  @override
  String toString() {
    return capitalizeText(firstName + " " + firstLastname);
  }
}
