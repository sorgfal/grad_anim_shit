import 'package:flutter/material.dart';

/// Где-то тут я понял, что еще до того, как вопрошающему ответили,
/// этот репозиторий и мини проект никому не нужен.
/// Маленький бунтарь во мне сказал, что теперь я точно должен дописать этот пример.
/// Больной он. Простыл, поди.
class HomeShitScreen extends StatelessWidget {
  const HomeShitScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedShitView(),
    );
  }
}

/// Отдельный виджет, потому-что его можно будет потом засунуть в stack и положить что-то сверху
/// STFUL потому-что с анимацией
class AnimatedShitView extends StatefulWidget {
  const AnimatedShitView({Key key}) : super(key: key);

  @override
  _AnimatedShitViewState createState() => _AnimatedShitViewState();
}

/// Дефолтная хрень для анимации. Миксин с тикером
class _AnimatedShitViewState extends State<AnimatedShitView>
    with TickerProviderStateMixin {
  /// Не могу обновиться до нулл-сефти из-за легаси проектов.
  /// По хорошему надо использовать late и final. Ну да ладно по старинке..

  AnimationController _controller;
  @override
  void initState() {
    super.initState();

    /// Ммм. Люблю долгие анимации
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    /// И чтобы повторялось
  }

  @override
  void dispose() {
    /// Ммм. Безопасность
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// В чем моя идея? Нужны 2 поверхности.
    /// Одна с черным статичным контейнером.
    /// Вторая с градиентом и анимированная
    /// Обе поверхности шириной в ширину окна
    /// Обе поверхности высотой в высоту экрана, но не совсем.
    /// Вторая поверхность(градиент) в начале анимации будет располагаться за
    /// границами окна в негативных координатах для выезда, а в конце анимации
    /// верхний край поверхности будет выходить на какое-то количество
    /// пикселей за окно, дабы не было черной полоски пикселей
    /// иногда это происходит без объяснения причин
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

              /// Вот где-то здесь мне надоело писать и решил, что с меня хватит
              /// я же не в исколле работаю, ну
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
