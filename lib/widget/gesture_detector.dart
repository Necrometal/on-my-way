import 'package:flutter/material.dart';

// Widget Detector() {
//   return GestureDetector(
//     onPanUpdate: (details) {
//       setState(() {
//         prevTranslation = translation;
//         translation += details.delta;
//       });
//     },
//     child: CustomPaint(
//       painter: WorldMapPainter(
//         translation: translation,
//         prevTranslation: prevTranslation,
//         lineWidth: lineWidth
//       ),
//       size: Size.infinite,
//     ),
//   );
// }