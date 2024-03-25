import 'package:sea_splash/widgets/chat/chat_messages.dart';
import 'package:sea_splash/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          'SeaSplash Chat',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       FirebaseAuth.instance.signOut();
        //     },
        //     icon: Icon(
        //       Icons.exit_to_app,
        //       color: Theme.of(context).colorScheme.primary,
        //     ),
        //   ),
        // ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: ChatMessages(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}
