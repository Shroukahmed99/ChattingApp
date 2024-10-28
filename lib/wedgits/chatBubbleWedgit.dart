import 'package:chatting/Models/mssageModel.dart';
import 'package:chatting/const.dart';
import 'package:flutter/material.dart';

class chatBubbleWedgit extends StatelessWidget {
  chatBubbleWedgit({super.key, required this.message});
  final Messages message;
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32),
              )),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 20, bottom: 20, right: 30),
            child: Text(
              message.message!,
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}

class chatBubbleForFriend extends StatelessWidget {
  chatBubbleForFriend({super.key, required this.message});
  final Messages message;
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: const BoxDecoration(
              color: Color(0xff006D84),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomLeft: Radius.circular(32),
              )),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 20, bottom: 20, right: 30),
            child: Text(
              message.message!,
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}
