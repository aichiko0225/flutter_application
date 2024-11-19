import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// 自定义组件方法简介
// 在Flutter中自定义组件有三种方式：通过组合其他组件、自绘和实现RenderObject。
// 1 组合多个Widget
// 这种方式是通过拼装多个组件来组合成一个新的组件。例如我们之前介绍的Container就是一个组合组件，它是由DecoratedBox、ConstrainedBox、Transform、Padding、Align等组件组成。
// 在Flutter中，组合的思想非常重要，Flutter提供了非常多的基础组件，而我们的界面开发其实就是按照需要组合这些组件来实现各种不同的布局而已。
//2 通过CustomPaint自绘
// 如果遇到无法通过现有的组件来实现需要的UI时，我们可以通过自绘组件的方式来实现，
// 例如我们需要一个颜色渐变的圆形进度条，而Flutter提供的CircularProgressIndicator并不支持在显示精确进度时对进度条应用渐变色
// （其valueColor 属性只支持执行旋转动画时变化Indicator的颜色），
// 这时最好的方法就是通过自定义组件来绘制出我们期望的外观。
// 我们可以通过Flutter中提供的CustomPaint和Canvas来实现UI自绘。
//3 通过RenderObject自绘
// Flutter提供的自身具有UI外观的组件，如文本Text、Image都是通过相应的RenderObject（我们将在“Flutter核心原理”一章中详细介绍RenderObject）渲染出来的，
// 如Text是由RenderParagraph渲染；而Image是由RenderImage渲染。
// RenderObject中最终也是通过Canvas API来绘制的，那么通过实现RenderObject的方式和上面介绍的通过CustomPaint和Canvas自绘的方式有什么区别？
// 其实答案很简单，CustomPaint只是为了方便开发者封装的一个代理类，它直接继承自SingleChildRenderObjectWidget，
// 通过RenderCustomPaint的paint方法将Canvas和画笔Painter(需要开发者实现，后面章节介绍)连接起来实现了最终的绘制（绘制逻辑在Painter中）。

// 组合的方式，完成一个渐变色的button
class GradientButton extends StatelessWidget {
  // 渐变色数组
  final List<Color>? colors;

  // 按钮宽高
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  final GestureTapCallback? onPressed;
  final Widget child;

  const GradientButton(
      {super.key,
      this.colors,
      this.width,
      this.height,
      this.onPressed,
      this.borderRadius,
      required this.child});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    //确保colors数组不空
    List<Color> _colors =
        colors ?? [theme.primaryColor, theme.primaryColorDark];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
        borderRadius: borderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TurnBox extends StatefulWidget {
  final double turns;
  final int speed;
  final Widget child;

  const TurnBox(
      {super.key,
      this.turns = .0, //旋转的“圈”数,一圈为360度，如0.25圈即90度
      this.speed = 200, //过渡动画执行的总时长
      required this.child});

  @override
  State<StatefulWidget> createState() {
    return _TurnBoxState();
  }
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, lowerBound: -double.infinity, upperBound: double.infinity);
    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(covariant TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    //旋转角度发生变化时执行过渡动画
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.speed ?? 200),
        curve: Curves.easeOut,
      );
    }
  }
}

class ChessPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('paint');
    var rect = Offset.zero & size;
    //画棋盘
    drawChessboard(canvas, rect);
    //画棋子
    drawPieces(canvas, rect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void drawPieces(Canvas canvas, Rect rect) {
    double eWidth = rect.width / 15;
    double eHeight = rect.height / 15;
    //画一个黑子
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    //画一个黑子
    canvas.drawCircle(
      Offset(rect.center.dx - eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
    //画一个白子
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(rect.center.dx + eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
  }

  void drawChessboard(Canvas canvas, Rect rect) {
    var paint = Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.fill
        ..color = Color(0xFFDCC48C);
    // 棋盘背景
    canvas.drawRect(rect, paint);

    //画棋盘网格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black38
      ..strokeWidth = 1.0;

    //画横线
    for (int i = 0; i <= 15; ++i) {
      double dy = rect.top + rect.height / 15 * i;
      canvas.drawLine(Offset(rect.left, dy), Offset(rect.right, dy), paint);
    }

    for (int i = 0; i <= 15; ++i) {
      double dx = rect.left + rect.width / 15 * i;
      canvas.drawLine(Offset(dx, rect.top), Offset(dx, rect.bottom), paint);
    }
  }
}

class ChessboardView extends StatelessWidget {
  const ChessboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: const Size(300, 300),
        painter: ChessPainter(),
      ),
    );
  }
}

class CustomPage extends StatefulWidget {
  const CustomPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomState();
  }
}

class _CustomState extends State<CustomPage> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义组件'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GradientButton(
            colors: const [Colors.orange, Colors.red],
            height: 50.0,
            onPressed: onTap,
            child: const Text("Submit"),
          ),
          TurnBox(
            turns: _turns,
            speed: 500,
            child: const Icon(
              Icons.refresh,
              size: 50,
            ),
          ),
          TurnBox(
            turns: _turns,
            speed: 1000,
            child: const Icon(
              Icons.refresh,
              size: 150.0,
            ),
          ),
          ElevatedButton(
            child: const Text("顺时针旋转1/5圈"),
            onPressed: () {
              setState(() {
                _turns += .2;
              });
            },
          ),
          ElevatedButton(
            child: const Text("逆时针旋转1/5圈"),
            onPressed: () {
              setState(() {
                _turns -= .2;
              });
            },
          ),
          const RepaintBoundary(child: ChessboardView())
        ],
      ),
    );
  }

  onTap() {
    print("button click");
  }
}
