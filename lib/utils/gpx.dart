import 'package:onmyway/models/gpx.dart';
import 'package:xml/xml.dart';

double defaultValue = 0.0;

Gpx generateGpxObject(String xml) {
  final doc = XmlDocument.parse(xml);
  final gpxElement = doc.getElement('gpx');

  // get title
  final title = gpxElement?.getElement('metadata')?.getElement('name');
  Gpx gpx = Gpx(title: title != null ? title.text : 'Unknown');

  final rtept = gpxElement?.getElement('rte')?.findAllElements('rtept');

  if(rtept != null){
    gpx.gpxRtept = generateGpxCoordinate(rtept);
  }

  return gpx;
}

List<GpxRtept> generateGpxCoordinate(Iterable<XmlElement> list){
  List<GpxRtept> gpxRtept = [];
  
  for(var el in list){
    final long = el.getAttribute('lon');
    final lat = el.getAttribute('lat');

    GpxRtept coord = GpxRtept(
      long: long != null ? double.parse(long) : defaultValue, 
      lat: lat != null ? double.parse(lat) : defaultValue
    );

    gpxRtept.add(coord);
  }

  return gpxRtept;
}

