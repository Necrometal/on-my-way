import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onmyway/models/gpx.dart';
import 'package:onmyway/utils/gpx.dart';
import 'package:onmyway/widget/custom_paint.dart';
import 'package:onmyway/utils/gps.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Offset translation = Offset.zero;
  Offset prevTranslation = Offset.zero;
  double lineWidth = 2;
  double _north = 0.0;
  Gps gps = Gps();
  Gpx? coordinate;

  Future test() async {
    try{
      String fileContents = await rootBundle.loadString('lib/assets/test.gpx');
      
      final gpx = generateGpxObject(fileContents);

      setState(() {
        coordinate = gpx;
      });
    }catch(e){
      print('error: $e');
    }
  }

  void _onMagnetometerEvent(MagnetometerEvent event) {
    setState(() {
      double x = event.x;
      double y = event.y;
      double z = event.z;
      double magneticNorth = atan2(y, x) * 180 / pi;
      magneticNorth = 90 - magneticNorth;
      if (magneticNorth < 0) {
        magneticNorth += 360;
      }

      _north = magneticNorth;
    });
  }

  @override
  void initState() {
    super.initState();
    magnetometerEvents.listen(_onMagnetometerEvent);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('On My Way'),
      ),
      body: CustomPaint(
        painter: WorldMapPainter(
          translation: translation,
          prevTranslation: prevTranslation,
          lineWidth: lineWidth,
          context: context,
          angle: _north,
          coordinate: coordinate
        ),
        size: Size.infinite,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          test();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
