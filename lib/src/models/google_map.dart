import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

class GoogleMapPlace {
  final String title;
  final LatLng latLng;
  final CameraPosition cameraPosition;
  final Marker marker;

  GoogleMapPlace({
    @required this.title,
    @required this.latLng,
    @required this.cameraPosition,
    this.marker,
  });
}
