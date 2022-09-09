import 'package:flutter/material.dart';
import 'package:system_alert_window/system_alert_window.dart';

class DraggableFloatingActionButton extends StatefulWidget {
  final Widget child;
  final Offset initialOffset;
  final VoidCallback onPressed;
  final GlobalKey<State<StatefulWidget>> parentKey;

  const DraggableFloatingActionButton({
    required this.child,
    required this.initialOffset,
    required this.onPressed,
    required this.parentKey,
  });

  @override
  State<StatefulWidget> createState() => _DraggableFloatingActionButtonState();
}

class _DraggableFloatingActionButtonState
    extends State<DraggableFloatingActionButton> {
  final GlobalKey _key = GlobalKey();

  bool _isDragging = false;
  late Offset _offset;
  late Offset _minOffset;
  late Offset _maxOffset;

  @override
  void initState() {
    super.initState();
    _offset = widget.initialOffset;

    WidgetsBinding.instance.addPostFrameCallback(_setBoundary);
  }

  void _setBoundary(_) {
    final RenderBox parentRenderBox =
        widget.parentKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox renderBox =
        _key.currentContext?.findRenderObject() as RenderBox;

    try {
      final Size parentSize = parentRenderBox.size;
      final Size size = renderBox.size;

      setState(() {
        _minOffset = const Offset(0, 0);
        _maxOffset = Offset(
            parentSize.width - size.width, parentSize.height - size.height);
      });
    } catch (e) {
      print('catch: $e');
    }
  }

  void _updatePosition(PointerMoveEvent pointerMoveEvent) {
    double newOffsetX = _offset.dx + pointerMoveEvent.delta.dx;
    double newOffsetY = _offset.dy + pointerMoveEvent.delta.dy;

    if (newOffsetX < _minOffset.dx) {
      newOffsetX = _minOffset.dx;
    } else if (newOffsetX > _maxOffset.dx) {
      newOffsetX = _maxOffset.dx;
    }

    if (newOffsetY < _minOffset.dy) {
      newOffsetY = _minOffset.dy;
    } else if (newOffsetY > _maxOffset.dy) {
      newOffsetY = _maxOffset.dy;
    }

    setState(() {
      _offset = Offset(newOffsetX, newOffsetY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: Listener(
        onPointerMove: (PointerMoveEvent pointerMoveEvent) {
          _updatePosition(pointerMoveEvent);

          setState(() {
            _isDragging = true;
          });
        },
        onPointerUp: (PointerUpEvent pointerUpEvent) {
          print('onPointerUp');

          if (_isDragging) {
            setState(() {
              _isDragging = false;
            });
          } else {
            widget.onPressed();
          }
        },
        child: GestureDetector(
          onTap: () {
            SystemAlertWindow.requestPermissions;

            SystemWindowHeader header = SystemWindowHeader(
              title: SystemWindowText(
                text: "courseName",
                fontSize: 24,
                fontWeight: FontWeight.BOLD,
                //textColor: Colors.black,
              ),
              padding: SystemWindowPadding.setSymmetricPadding(12, 12),
              decoration: SystemWindowDecoration(startColor: Colors.grey[100]),
            );

            SystemWindowFooter footer = SystemWindowFooter(
              buttons: [
                SystemWindowButton(
                  text: SystemWindowText(
                      text: "Simple button",
                      fontSize: 12,
                      textColor: const Color.fromRGBO(250, 139, 97, 1)),
                  tag: "simple_button", //useful to identify button click event
                  padding: SystemWindowPadding(
                      left: 10, right: 10, bottom: 10, top: 10),
                  width: 0,
                  height: SystemWindowButton.WRAP_CONTENT,
                  decoration: SystemWindowDecoration(
                      startColor: Colors.white,
                      endColor: Colors.white,
                      borderWidth: 0,
                      borderRadius: 0.0),
                ),
                SystemWindowButton(
                  text: SystemWindowText(
                      text: "Focus button",
                      fontSize: 12,
                      textColor: Colors.white),
                  tag: "focus_button",
                  width: 0,
                  padding: SystemWindowPadding(
                      left: 10, right: 10, bottom: 10, top: 10),
                  height: SystemWindowButton.WRAP_CONTENT,
                  decoration: SystemWindowDecoration(
                      startColor: const Color.fromRGBO(250, 139, 97, 1),
                      endColor: const Color.fromRGBO(247, 28, 88, 1),
                      borderWidth: 0,
                      borderRadius: 30.0),
                )
              ],
              padding: SystemWindowPadding(left: 16, right: 16, bottom: 12),
              decoration: SystemWindowDecoration(startColor: Colors.white),
              buttonsPosition: ButtonPosition.CENTER,
            );
            // Ask for a break widget
            // DrawOverApps(),
            // ChoiceQuiz(),
            // CongratsWidget(),
            // FaceDetectionAlert(),

            SystemWindowBody body = SystemWindowBody(
              rows: [
                EachRow(
                  columns: [
                    EachColumn(
                      text: SystemWindowText(
                        text: "Some body",
                        fontSize: 12,
                        textColor: Colors.black45,
                      ),
                    ),
                  ],
                  gravity: ContentGravity.CENTER,
                ),
              ],
              padding:
                  SystemWindowPadding(left: 16, right: 16, bottom: 12, top: 12),
            );

            SystemAlertWindow.showSystemWindow(
              height: 10,
              header: header,
              body: body,
              footer: footer,
              margin:
                  SystemWindowMargin(left: 8, right: 8, top: 100, bottom: 0),
              gravity: SystemWindowGravity.TOP,
              prefMode: SystemWindowPrefMode.BUBBLE,
            );
          },
          child: Container(
            key: _key,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
