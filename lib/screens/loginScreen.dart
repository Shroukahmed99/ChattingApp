import 'package:chatting/const.dart';
import 'package:chatting/helper/snakBar.dart';
import 'package:chatting/screens/RegisterScreen.dart';
import 'package:chatting/screens/chattingScreen.dart';
import 'package:chatting/wedgits/ButtonWedgit.dart';
import 'package:chatting/wedgits/TextFieldWedgit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LonginScreen extends StatefulWidget {
  LonginScreen({super.key});
  static String id = 'Login_Page';

  @override
  State<LonginScreen> createState() => _LonginScreenState();
}

class _LonginScreenState extends State<LonginScreen> {
  bool isLoading = false;
  String? email, password;

  GlobalKey<FormState> formKey = GlobalKey();

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
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset(
                  PimaryLogo,
                  height: 100,
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
                  height: 25,
                ),
                const Row(
                  children: [
                    Text(
                      'LOGIN',
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
                    }),
                const SizedBox(
                  height: 15,
                ),
                TextFieldCustom(
                    hintText: 'Password',
                    obscure: true,
                    onChanged: (data) {
                      password = data;
                    }),
                const SizedBox(
                  height: 15,
                ),

                ButtonWedge(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUserMethod();
                          Navigator.pushNamed(context, ChattingScreen.id,
                              arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            SnackBarMethod(
                                context, 'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            SnackBarMethod(context,
                                'Wrong password provided for that user.');
                          } else if (e.code == 'invalid-credential') {
                            SnackBarMethod(context,
                                'Invalid login credentials. Please check your information.');
                          }
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    },
                    buttonName: 'Login'),

                // ButtonWedge(
                //     onTap: () async {
                //       if (formKey.currentState!.validate()) {
                //         isLoading = true;
                //         setState(() {});
                //         try {
                //           await loginUserMethod();
                //         } on FirebaseAuthException catch (e) {
                //           if (e.code == 'user-not-found') {
                //             SnackBarMethod(
                //                 context, 'No user found for that email.');
                //           } else if (e.code == 'wrong-password') {
                //             SnackBarMethod(context,
                //                 'Wrong password provided for that user.');
                //           }
                //         } catch (e) {
                //           print(e);
                //           SnackBarMethod(context, 'oops ,try again');
                //         }
                //         isLoading = false;
                //         setState(() {});
                //       }
                //     },
                //     buttonName: 'LOGIN IN'),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'don\'t have an account?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      child: const Text(
                        'Register',
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
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUserMethod() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
