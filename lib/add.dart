import 'package:flutter/material.dart';
import 'package:grad_anim_shit/home_shit_screen.dart';

class GradShitApp extends StatelessWidget {
  const GradShitApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// На написании этого момента, человеку уже ответили, что нужно делать
      /// В деталях. Так что тут был момент безисходности...
      home: HomeShitScreen(),
    );
  }
}
