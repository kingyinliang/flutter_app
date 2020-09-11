import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

/// 创建EventBus
EventBus eventBus = EventBus();

/// Event 修改点击第几个
class IndexEvent {
  var index;

  IndexEvent(this.index);
}

// ignore: must_be_immutable
class SlideButton extends StatefulWidget {
  var index;
  Widget child;
  List<Widget> buttons;
  GlobalKey<SlideButtonState> key;
  double singleButtonWidth;
  VoidCallback onDown;

  VoidCallback onSlideStarted;

  VoidCallback onSlideCompleted;

  VoidCallback onSlideCanceled;

  SlideButton(
      {this.key,
      @required this.index,
      @required this.child,
      @required this.singleButtonWidth,
      @required this.buttons,
      this.onSlideStarted,
      this.onSlideCompleted,
      this.onSlideCanceled})
      : super(key: key);

  @override
  SlideButtonState createState() => SlideButtonState();
}

class SlideButtonState extends State<SlideButton>
    with TickerProviderStateMixin {
  double translateX = 0;
  double maxDragDistance;
  var eventListen;
  final Map<Type, GestureRecognizerFactory> gestures =
      <Type, GestureRecognizerFactory>{};

  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    eventListen = eventBus.on<IndexEvent>().listen((event) {
      close();
    });
    maxDragDistance = widget.singleButtonWidth * widget.buttons.length;
    gestures[HorizontalDragGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>(
      () => HorizontalDragGestureRecognizer(debugOwner: this),
      (HorizontalDragGestureRecognizer instance) {
        instance
          ..onDown = onHorizontalDragDown
          ..onUpdate = onHorizontalDragUpdate
          ..onEnd = onHorizontalDragEnd;
      },
    );
    animationController = AnimationController(
        lowerBound: -maxDragDistance,
        upperBound: 0,
        vsync: this,
        duration: Duration(milliseconds: 300))
      ..addListener(() {
        translateX = animationController.value;
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              right: -maxDragDistance - translateX,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: widget.buttons,
              ),
            ),
            RawGestureDetector(
              gestures: gestures,
              child: Transform.translate(
                offset: Offset(translateX, 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: widget.child,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        onWillPop: () async {
          if (translateX != 0) {
            close();
            return false;
          }
          return true;
        });
  }

  void onHorizontalDragDown(DragDownDetails details) {
    // widget.onDown();
    eventBus.fire(IndexEvent(widget.index));
    if (widget.onSlideStarted != null) widget.onSlideStarted.call();
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    translateX = (translateX + details.delta.dx).clamp(-maxDragDistance, 0.0);
    setState(() {});
  }

  void onHorizontalDragEnd(DragEndDetails details) {
    animationController.value = translateX;
    if (details.velocity.pixelsPerSecond.dx > 200) {
      close();
    } else if (details.velocity.pixelsPerSecond.dx < -200) {
      open();
    } else {
      if (translateX.abs() > maxDragDistance / 2) {
        open();
      } else {
        close();
      }
    }
  }

  void open() {
    if (translateX != -maxDragDistance)
      animationController.animateTo(-maxDragDistance).then((_) {
        if (widget.onSlideCompleted != null) widget.onSlideCompleted.call();
      });
  }

  void close() {
    if (translateX != 0)
      animationController.animateTo(0).then((_) {
        if (widget.onSlideCanceled != null) widget.onSlideCanceled.call();
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    //取消订阅
    eventListen.cancel();
    super.dispose();
  }
}
