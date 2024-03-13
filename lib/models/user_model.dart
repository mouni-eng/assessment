import 'package:google_sign_in/google_sign_in.dart';

class UserModel {
  String? email;
  String? fullName;
  String? personalId;
  String? password;

  UserModel.instance();

  UserModel({
    required this.email,
    required this.fullName,
    this.password,
    required this.personalId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fullName: json['fullName'] as String,
        email: json['email'] as String,
        personalId: json['personalId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'fullName': fullName,
        'personalId': personalId,
      };
}

abstract class UserDataAdapter {
  UserModel adapt(dynamic userResponse);
}

class SocialSignInAdapter implements UserDataAdapter {
  @override
  UserModel adapt(dynamic userResponse) {
    if (userResponse is GoogleSignInAccount) {
      return UserModel(
        personalId: userResponse.id,
        fullName: userResponse.displayName,
        email: userResponse.email,
      );
    } else if (userResponse is FacebookSignInAccount) {
      return UserModel(
        personalId: userResponse.id,
        fullName: userResponse.name,
        email: userResponse.email,
      );
    } else {
      throw Exception('Unsupported user response format');
    }
  }
}

class FacebookSignInAccount {
  final String name;
  final String email;
  final String id;

  FacebookSignInAccount({
    required this.name,
    required this.email,
    required this.id,
  });

  factory FacebookSignInAccount.fromJson(Map<String, dynamic> json) {
    return FacebookSignInAccount(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      id: json['id'] ?? '',
    );
  }
}
