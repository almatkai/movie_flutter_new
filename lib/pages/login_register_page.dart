import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth.dart';

//divmad-gutnoh-4cyfzI
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;
  bool isAdmin = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> googleSignIn() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<UserCredential> signInWithGitHub() async {
    // Create a GitHubSignIn instance
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: "9fd1574211870058c112",
        clientSecret: "fd45922f8784067e83a22d1bc8748c23869dea3c",
        redirectUrl:
            'https://movie-flutter-new.firebaseapp.com/__/auth/handler');

    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);

    // Create a credential from the access token
    final githubAuthCredential = GithubAuthProvider.credential(result.token!);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(githubAuthCredential);
  }

  Future<void> signInWithGuestMode() async {
    // Trigger the sign-in flow
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text("Firebase Auth");
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: isLogin
            ? signInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Text(isLogin ? "Login" : "Register"));
  }

  Widget _googleSignInButton() {
    return ElevatedButton(
        onPressed: googleSignIn, child: const Text("Sign in with Google"));
  }

  Widget _githubSignInButton() {
    return ElevatedButton(
        onPressed: signInWithGitHub, child: const Text("Sign in with Github"));
  }

  Widget _anonSignInButton() {
    return ElevatedButton(
        onPressed: signInWithGuestMode,
        child: const Text("Sign in as a guest"));
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? "Register instead" : "Login instead"));
  }

  Widget _signInAsAdmin() {
    return TextButton(
        onPressed: () {
          setState(() {
            isAdmin = !isAdmin;
          });
        },
        child: Text(isAdmin ? "Sign in as user" : "Sign in as admin"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _title()),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('email', _controllerEmail),
            _entryField('password', _controllerPassword),
            _errorMessage(),
            _submitButton(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _loginOrRegisterButton(),
              _signInAsAdmin(),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _googleSignInButton(),
              _githubSignInButton(),
            ]),
            _anonSignInButton()
          ],
        ),
      ),
    );
  }
}
