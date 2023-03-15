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
    // set scale factor
    double scaleFactor = size.width / (180 * 2);

    // paints to use for line
    paints = Paint()
      ..color = const Color.fromARGB(255, 11, 166, 187)
      ..strokeWidth = lineWidth;

    // paint indicator
    final indicator = Paint()
      ..color = Colors.blue
      ..strokeWidth = lineWidth + 3;

    /**
     * set the indicator to the center of canvas
     * need caclul for tranlating the canvas
     * depending on current position
     */
    canvas.translate(size.width / 2, size.height / 2);

    // draw indicator
    canvas.drawCircle(
      const Offset(0, 0),
      10,
      Paint()..color = Colors.blue,
    );

    canvas.drawLine(
      const Offset(0, 0), 
      const Offset(0, -20), 
      indicator
    );

    /**
     * save the canvas to make sur that
     * on translating the canvas the position 
     * of the indicator remains in the center
     */
    canvas.save();

    /**
     * set the canvas to 0,0
     * to make sure that the canvas behave normaly
     */
    canvas.translate(0, 0);

    // rotate canvas depending of result of magnetometer
    canvas.rotate(angle * pi / 180);
    // draw the route here from registered route

    // trace route
    if(coordinate != null){
      traceRoute(canvas, coordinate!.gpxRtept, paints, scaleFactor);
    }

    // restore the canvas from save
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
