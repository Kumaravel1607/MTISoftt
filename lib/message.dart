import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  //

  Messages({
    Key? key,
    //required this.id
  }) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message')),
    );
  }
}
