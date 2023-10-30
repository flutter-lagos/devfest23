import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  googleSignIn() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        idToken: gAuth.idToken, accessToken: gAuth.accessToken);
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signInWithEmailAndTicketNo(String email, String ticketNo) async {
    try{
     await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: ticketNo);
    }on FirebaseAuthException catch(e){
      if(e.code=='user-not-found'){

      }else if(e.code=='wrong-password'){
       // showDialog(context: context, builder: builder)
      }
    }
    
  }
}
