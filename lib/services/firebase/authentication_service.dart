import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
          email: email,
          password: password);

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
      });

      await userCredential.user!.updateDisplayName(name);

      print('USER CREATED ====${userCredential.user}');

      return userCredential.user;

    } catch (e) {
      print('Error during sign up: $e');
      throw e;
    }
  }

  Future<void> sendOtpToEmail(String email, String otp) async {
    print('OTP for $email: $otp'); // Simulating email sending
  }

  Future<bool> verifyOTP(String enteredOTP, String generatedOTP) async {
    return enteredOTP == generatedOTP;
  }


}
