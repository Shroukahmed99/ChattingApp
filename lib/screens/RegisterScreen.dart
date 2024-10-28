import 'package:chatting/const.dart';
import 'package:chatting/helper/snakBar.dart';
import 'package:chatting/screens/chattingScreen.dart';
import 'package:chatting/wedgits/ButtonWedgit.dart';
import 'package:chatting/wedgits/TextFieldWedgit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static String id = 'Register_Page';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 75,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    'Chatting',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                const Row(
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldCustom(
                  hintText: 'Email',
                  onChanged: (data) {
                    email = data;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFieldCustom(
                  hintText: 'Password',
                  obscure: true,
                  onChanged: (data) {
                    password = data;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ButtonWedge(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await RegisterUserMethod();
                          Navigator.pushNamed(context, ChattingScreen.id,
                              arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            SnackBarMethod(
                                context, 'The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            SnackBarMethod(context,
                                'The account already exists for that email.');
                          }
                        } catch (e) {
                          SnackBarMethod(context,
                              'oops there was an error ,please try again');
                        }

                        isLoading = false;
                        setState(() {});
                      }
                    },
                    buttonName: 'Register'),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'already have an account?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        '  LOGIN',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffc7ede6),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> RegisterUserMethod() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
