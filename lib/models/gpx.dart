class Gpx {
  Gpx({
    required this.title
  });

  String title;
  List<GpxRtept> gpxRtept = [];
}

class GpxRtept {
  GpxRtept({
    required this.long,
    required this.lat,
  });

  double long;
  double lat;
}
