// This will be an api to update and change user details

import 'package:firebase_auth/firebase_auth.dart';

class UserInfoApi {
  final FirebaseUser _firebaseUser;

  UserInfoApi({FirebaseUser firebaseUser})
      : _firebaseUser = firebaseUser ?? FirebaseAuth.instance.currentUser();




  Future<void> updateProfile(
      {String newDisplayName, String newPhotoUrl}) async {

    UserUpdateInfo _userUpdateInfo = UserUpdateInfo()
    ..displayName = newDisplayName
    ..photoUrl = newPhotoUrl;

    _firebaseUser.updateProfile(_userUpdateInfo);
  }
}
