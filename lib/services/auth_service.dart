import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mohamed_mounir_assesment/constants.dart';
import 'package:mohamed_mounir_assesment/infrastructure/cache_helper.dart';
import 'package:mohamed_mounir_assesment/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  register({required UserModel model}) async {
    await _auth
        .createUserWithEmailAndPassword(
      email: model.email!,
      password: model.password!,
    )
        .then((value) {
      model.personalId = value.user!.uid;
      saveUser(model: model);
    });
  }

  saveUser({required UserModel model}) async {
    await _firestore
        .collection(userRef)
        .doc(model.personalId)
        .set(model.toJson())
        .then((value) {
      CacheHelper.saveData(key: "uid", value: model.personalId);
    });
  }

  login({required email, required password}) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      CacheHelper.saveData(key: "uid", value: value.user!.uid);
    });
  }

  Future<void> loginWithGoogle() async {
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.disconnect();
    }
    var loginData = await _googleSignIn.signIn();
    if (loginData != null) {
      CacheHelper.saveData(key: "uid", value: loginData.id);
      UserModel? userModel = await getUser();
      if (userModel == null) {
        final userAdapter = SocialSignInAdapter();
        userModel = userAdapter.adapt(loginData);
        await saveUser(model: userModel);
      }
    }
  }

  Future<void> loginWithFacebook() async {
    final LoginResult loginResult = await _facebookAuth.login();
    if (loginResult.status == LoginStatus.success) {
      final AccessToken accessToken = loginResult.accessToken!;

      final userData = await FacebookAuth.instance.getUserData(
        fields: "email,name,id",
      );

      FacebookSignInAccount loginData =
          FacebookSignInAccount.fromJson(userData);

      CacheHelper.saveData(key: "uid", value: accessToken.userId);

      UserModel? userModel = await getUser();

      if (userModel == null) {
        final userAdapter = SocialSignInAdapter();
        userModel = userAdapter.adapt(loginData);
        await saveUser(model: userModel);
      }
    }
  }

  Future<UserModel?> getUser() async {
    var uId = await CacheHelper.getData(key: "uid");
    UserModel? model;
    if (uId != null) {
      var response = await _firestore.collection(userRef).doc(uId).get();
      if (response.data() != null) {
        model = UserModel.fromJson(response.data()!);
      }
    }
    return model;
  }

  logOut() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
    await _facebookAuth.logOut();
    await CacheHelper.removeData(
      key: 'uid',
    );
  }
}
