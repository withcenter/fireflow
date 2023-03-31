/// UserPrivateDataModel is a model class for user private data
///
/// See README
class UserPrivateDataModel {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;

  UserPrivateDataModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory UserPrivateDataModel.fromJson(Map<String, dynamic> json) {
    return UserPrivateDataModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
    };
  }
}
