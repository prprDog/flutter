import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ComponentData {
  String id;
  double rotation;
  double x;
  double y;
  double width;
  double height;

//<editor-fold desc="Data Methods">
  ComponentData({
    required this.id,
    required this.rotation,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is ComponentData &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              rotation == other.rotation &&
              x == other.x &&
              y == other.y &&
              width == other.width &&
              height == other.height);

  @override
  int get hashCode =>
      id.hashCode ^
      rotation.hashCode ^
      x.hashCode ^
      y.hashCode ^
      width.hashCode ^
      height.hashCode;

  @override
  String toString() {
    return 'ComponentData{ id: $id, rotation: $rotation, x: $x, y: $y, width: $width, height: $height,}';
  }

  ComponentData copyWith({
    String? id,
    double? rotation,
    double? x,
    double? y,
    double? width,
    double? height,
  }) {
    return ComponentData(
      id: id ?? this.id,
      rotation: rotation ?? this.rotation,
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'rotation': this.rotation,
      'x': this.x,
      'y': this.y,
      'width': this.width,
      'height': this.height,
    };
  }

  factory ComponentData.fromMap(Map<String, dynamic> map) {
    return ComponentData(
      id: map['id'] as String,
      rotation: map['rotation'] as double,
      x: map['x'] as double,
      y: map['y'] as double,
      width: map['width'] as double,
      height: map['height'] as double,
    );
  }

//</editor-fold>
}

@JsonSerializable()
class Label {
  double width;
  double height;
  int color;
  List<ComponentData> components;


  Label({
    required this.width,
    required this.height,
    required this.color,
    required this.components,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Label &&
              runtimeType == other.runtimeType &&
              width == other.width &&
              height == other.height &&
              color == other.color &&
              components == other.components
          );


  @override
  int get hashCode =>
      width.hashCode ^
      height.hashCode ^
      color.hashCode ^
      components.hashCode;


  @override
  String toString() {
    return 'Label{ width: $width, height: $height, color: $color, components: $components,}';
  }


  Label copyWith({
    double? width,
    double? height,
    int? color,
    List<ComponentData>? components,
  }) {
    return Label(
      width: width ?? this.width,
      height: height ?? this.height,
      color: color ?? this.color,
      components: components ?? this.components,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'width': this.width,
      'height': this.height,
      'color': this.color,
      'components': jsonEncode(this.components.map((e) => e.toMap()).toList()),
    };
  }

  factory Label.fromMap(Map<String, dynamic> map) {
    List<dynamic> components = jsonDecode(map['components']);
    var result = components.map((e) => ComponentData.fromMap(e)).toList();
    return Label(
      width: map['width'] as double,
      height: map['height'] as double,
      color: map['color'] as int,
      components: result,
    );
  }
}
