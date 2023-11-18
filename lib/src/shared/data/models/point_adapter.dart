

import 'dart:math';

import 'package:hive/hive.dart';

class PointAdapter extends TypeAdapter<Point<num>> {
  @override
  Point<num> read(BinaryReader reader) {
    final x = reader.readInt();
    final y = reader.readInt();
    return Point(x, y);
  }

  @override
  int get typeId => 12;

  @override
  void write(BinaryWriter writer, Point<num> obj) {
    writer.write(obj.x);
    writer.write(obj.y);
  }

}