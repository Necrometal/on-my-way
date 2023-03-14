import 'package:flutter/material.dart';
import 'dart:math';

import 'package:onmyway/models/gpx.dart';

const sensitivity = 10;
const echelle = 5;

class WorldMapPainter extends CustomPainter {
  // final LocationData currentLocation;

  final Offset translation;
  final Offset prevTranslation;
  final double lineWidth;
  final BuildContext context;
  final double angle;

  final Gpx? coordinate;
  late Paint paints;

  WorldMapPainter({
    required this.translation,
    required this.prevTranslation,
    required this.context,
    required this.angle,
    this.coordinate,
    this.lineWidth = 1
  });
  // WorldMapPainter({this.currentLocation});

  @override
  void paint(Canvas canvas, Size size) {
    double scaleFactor = size.width / (180 * 2);

    paints = Paint()
      ..color = const Color.fromARGB(255, 11, 166, 187)
      ..strokeWidth = lineWidth;

    final indicator = Paint()
      ..color = Colors.blue
      ..strokeWidth = lineWidth + 3;

    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(
      Offset(0, 0),
      10,
      Paint()..color = Colors.blue,
    );

    canvas.drawLine(Offset(0, 0), Offset(0, -20), indicator);
    canvas.save();

    canvas.translate(0, 0);
    canvas.rotate(angle * pi / 180);
    // draw the route here from registered route


    if(coordinate != null){
      traceRoute(canvas, coordinate!.gpxRtept, paints, scaleFactor);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

void traceRoute(Canvas canvas, List<GpxRtept> list, Paint paints, double scale){
  GpxRtept? previous;

  for(var el in list){
    Offset x;
    Offset y;

    if(previous != null){
      x = scaling(previous, scale);
      y = scaling(el, scale);
      canvas.drawLine(x, y, paints);
    }

    previous = el;
  }
}

Offset scaling(GpxRtept coordinate, double scaleFactor){
  double y = (coordinate.long + 180) * scaleFactor;
  double x = (90 - coordinate.lat) * scaleFactor;
  return Offset(x, y);
}
