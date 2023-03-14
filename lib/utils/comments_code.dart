// void _onAccelerometerEvent(AccelerometerEvent event) {
//     print(' accele >> ${event.x}');
//     setState(() {
//       double x = event.x;
//       double y = event.y;
//       double z = event.z;
//       double norm = math.sqrt(x * x + y * y + z * z);
//       x /= norm;
//       y /= norm;
//       z /= norm;
//       double pitch = math.asin(-x);
//       double roll = math.atan2(-y, -z);
//       azimuthAngle = roll * 180 / math.pi;
//       if (azimuthAngle < 0) {
//         azimuthAngle += 360;
//       }
//     });
//   }

//   void _onMagnetometerEvent(MagnetometerEvent event) {
//     // print(' magneto >> ${event.x}');
//     // setState(() {
//     //   double x = event.x;
//     //   double y = event.y;
//     //   double z = event.z;
//     //   double norm = math.sqrt(x * x + y * y + z * z);
//     //   x /= norm;
//     //   y /= norm;
//     //   z /= norm;
//     //   double magneticNorth = math.atan2(y, x) * 180 / math.pi;
//     //   print(magneticNorth);
//     //   if (magneticNorth < 0) {
//     //     magneticNorth += 360;
//     //   }
//     //   if (magneticNorth > 45 && magneticNorth < 135) {
//     //     isFacingNorth = false; // device is facing south
//     //   } else {
//     //     isFacingNorth = true; // device is facing north
//     //   }
//     // });
//     setState(() {
//       double x = event.x;
//       double y = event.y;
//       double z = event.z;
//       double norm = math.sqrt(x * x + y * y + z * z);
//       x /= norm;
//       y /= norm;
//       z /= norm;
//       double magneticNorth = math.atan2(y, x) * 180 / math.pi;
//       if (magneticNorth < 0) {
//         magneticNorth += 360;
//       }
//       azimuthAngle -= magneticNorth;
//       if (azimuthAngle < 0) {
//         azimuthAngle += 360;
//       }
//       if (azimuthAngle > 360) {
//         azimuthAngle -= 360;
//       }
//     });
//   }

// void _onAccelerometerEvent(AccelerometerEvent event) {
//     setState(() {
//       _north = atan2(event.z, event.x) + pi;
//     });
//   }

//   void _onMagnetometerEvent(MagnetometerEvent event) {
//     setState(() {
//       final double x = event.x * cos(_north) +
//           event.y * sin(_north); // adjust for the north direction
//       final double y = event.y * cos(_north) -
//           event.x * sin(_north); // adjust for the north direction
//       _direction = atan2(y, x);
//     });
//   }