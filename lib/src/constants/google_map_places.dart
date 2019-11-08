import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/src/models/model.dart';

Map<String, LatLng> getCoordinates(BuildContext context) {
  return <String, LatLng>{
    S.of(context).kozakPalace: const LatLng(47.83410865, 35.1251964),
    S.of(context).hydroelectricStation: const LatLng(47.86728682, 35.08997312),
    S.of(context).zaporozhianSich: const LatLng(47.85734045, 35.07477421),
  };
}

Set<GoogleMapPlace> getGoogleMapPlaces(BuildContext context) {
  final coordinates = getCoordinates(context);
  final advertisementPlaceholder = S.of(context).advertisementPlaceholder;

  return <GoogleMapPlace>{
    GoogleMapPlace(
      title: coordinates.keys.toList()[0],
      latLng: coordinates.values.toList()[0],
      cameraPosition: CameraPosition(
        target: coordinates.values.toList()[0],
        zoom: 18.5,
        tilt: 30,
        bearing: 220,
      ),
      marker: Marker(
        markerId: MarkerId(coordinates.keys.toList()[0]),
        position: coordinates.values.toList()[0],
        infoWindow: InfoWindow(
          title: coordinates.keys.toList()[0],
          snippet: advertisementPlaceholder,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    ),
    GoogleMapPlace(
      title: coordinates.keys.toList()[1],
      latLng: coordinates.values.toList()[1],
      cameraPosition: CameraPosition(
        target: coordinates.values.toList()[1],
        zoom: 16,
        tilt: 30,
        bearing: 60,
      ),
      marker: Marker(
        markerId: MarkerId(coordinates.keys.toList()[1]),
        position: coordinates.values.toList()[1],
        infoWindow: InfoWindow(
          title: coordinates.keys.toList()[1],
          snippet: advertisementPlaceholder,
        ),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ),
    ),
    GoogleMapPlace(
      title: coordinates.keys.toList()[2],
      latLng: coordinates.values.toList()[2],
      cameraPosition: CameraPosition(
        target: coordinates.values.toList()[2],
        zoom: 19,
        tilt: 50,
        bearing: 130,
      ),
      marker: Marker(
        markerId: MarkerId(coordinates.keys.toList()[2]),
        position: coordinates.values.toList()[2],
        infoWindow: InfoWindow(
          title: coordinates.keys.toList()[2],
          snippet: advertisementPlaceholder,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    ),
  };
}
