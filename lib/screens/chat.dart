import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sea_splash/widgets/chat/chat_messages.dart';
import 'package:sea_splash/widgets/chat/new_message.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();

    fcm.subscribeToTopic('chat');

    final token = await fcm.getToken();
    print(token);
  }

  @override
  void initState() {
    super.initState();

    setupPushNotifications();
  }

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
