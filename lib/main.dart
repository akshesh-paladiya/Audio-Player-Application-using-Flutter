import 'package:flutter/material.dart';
import 'audio_player.dart';

void main() {

  runApp(
      MaterialApp(
        initialRoute: 'audio',
        debugShowCheckedModeBanner: false,
        routes: {
          'audio': (context) => Audio(title: 'Audio Player Song in Assets',),
        },
      )
  );
}





