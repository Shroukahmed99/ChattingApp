import 'package:chatting/Models/mssageModel.dart';
import 'package:chatting/const.dart';
import 'package:chatting/wedgits/chatBubbleWedgit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChattingScreen extends StatelessWidget {
  ChattingScreen({super.key});
  static String id = 'ChattingScreen';
  final _controller = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController controllerEditing = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreateAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        _controller.animateTo(
          0,
          duration: Duration(seconds: 1),
          curve: Curves.easeIn,
        );

        if (snapshot.hasData) {
          List<Messages> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Messages.fromJson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    PimaryLogo,
                    width: 50,
                  ),
                  const Text(
                    'chatting',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: primaryfontFamily),
                  ),
                ],
              ),
              // centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      controller: _controller,
                      reverse: true,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return messageList[index].id == email
                            ? chatBubbleWedgit(
                                message: messageList[index],
                              )
                            : chatBubbleForFriend(message: messageList[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: controllerEditing,
                    onSubmitted: (data) {
                      messages.add(
                        {
                          'message': data,
                          kCreateAt: DateTime.now(),
                          'id': email,
                        },
                      );

                      controllerEditing.clear();
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: const Icon(Icons.send),
                      suffixIconColor: kPrimaryColor,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(), // مؤشر تحميل
            ),
          );
        }
      },
    );
  }
}
