import 'package:flutter/material.dart';
import 'dart:math' as math;

class EditContainer extends StatefulWidget {
  final Widget child;
  final Matrix4 matrix4;
  final GestureScaleUpdateCallback? moveCallback;

  @override
  State<StatefulWidget> createState() {
    return _EditContainerState();
  }

  const EditContainer(
      {super.key,
      required this.child,
      required this.matrix4,
      required this.moveCallback});
}

class _EditContainerState extends State<EditContainer> {
  @override
  Widget build(BuildContext context) {
    return Transform(
        transform: widget.matrix4,
        child: GestureDetector(
          onScaleUpdate: widget.moveCallback,
          child: widget.child,
        ));
  }
}

class ImageComponent extends StatefulWidget {
  final Matrix4 matrix4;
  double x;
  double y;
  double rotation;
  double width;
  double height;

  ImageComponent(
      {super.key,
      required this.matrix4,
      required this.x,
      required this.y,
      required this.rotation,
      required this.width,
      required this.height});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImageComponent();
  }
}

class _ImageComponent extends State<ImageComponent> {
  Matrix4 componentMatrix4 = Matrix4.identity();

  @override
  void initState() {
    super.initState();
    double angle = widget.rotation * math.pi / 180;
    componentMatrix4
      ..translate(widget.x, widget.y)
      ..translate(widget.width / 2, widget.height / 2)
      ..rotateZ(angle)
      ..translate(-widget.width / 2, -widget.height / 2);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return EditContainer(
      matrix4: widget.matrix4.multiplied(componentMatrix4),
      moveCallback: (ScaleUpdateDetails details) {
        Matrix4 matrix = Matrix4.copy(componentMatrix4)
          ..translate(details.focalPointDelta.dx, details.focalPointDelta.dy);
        setState(() {
          componentMatrix4 = matrix;
        });
      },
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
            width: widget.width,
            height: widget.height,
            alignment: Alignment.topLeft,
            color: Colors.white,
            child: const Image(image: AssetImage('assets/robot.png'))),
      ),
    );
  }
}

class ComponentData {
  double rotation;
  double x;
  double y;

  ComponentData({required this.rotation, required this.x, required this.y});
}
