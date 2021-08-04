import 'package:flutter/material.dart';

class HomeShitScreen extends StatelessWidget {
  const HomeShitScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedShitView(),
    );
  }
}

class AnimatedShitView extends StatefulWidget {
  const AnimatedShitView({Key key}) : super(key: key);

  @override
  _AnimatedShitViewState createState() => _AnimatedShitViewState();
}

class _AnimatedShitViewState extends State<AnimatedShitView>
    with TickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: [
          BackgroundLayer(),
          PositionedTransition(
            rect: RelativeRectTween(
              begin: RelativeRect.fromLTRB(
                0,
                -size.height,
                0,
                size.height,
              ),
              end: RelativeRect.fromLTRB(0, -100, 0, 0),
            ).animate(CurvedAnimation(
              parent: _controller,
              curve: Curves.easeInOut,
            )),
            child: ForegroundLayed(),
          ),
        ],
      ),
    );
  }
}

class BackgroundLayer extends StatelessWidget {
  const BackgroundLayer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
    );
  }
}

class ForegroundLayed extends StatelessWidget {
  const ForegroundLayed({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.red, Colors.black]),
    ));
  }
}
