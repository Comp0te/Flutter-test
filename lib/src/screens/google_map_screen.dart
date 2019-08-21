import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/models/model.dart';

class GoogleMapScreen extends StatefulWidget {
  @override
  State<GoogleMapScreen> createState() => GoogleMapScreenState();
}

class GoogleMapScreenState extends State<GoogleMapScreen> {
  final _mapController = Completer<GoogleMapController>();
  final _activeIndexBloc = ActiveIndexBloc();
  final _streamController = StreamController<LatLngBounds>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () => _mapController.future)
        .asStream()
        .take(1)
        .asyncMap((controller) => controller.getVisibleRegion())
        .listen((latLngBounds) => _streamController.add(latLngBounds));
  }

  @override
  void dispose() {
    _streamController?.close();
    _activeIndexBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: googleMapPlaces.map((place) => place.marker).toSet(),
            mapType: MapType.hybrid,
            initialCameraPosition: googleMapPlaces.elementAt(0).cameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
          ),
          Positioned(
            top: 30,
            left: 15,
            width: MediaQuery.of(context).size.width - 30,
            child: Container(
              child: StreamBuilder<LatLngBounds>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  return Opacity(
                    opacity: 0.8,
                    child: snapshot.connectionState == ConnectionState.active
                        ? Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _latLngBoundsText(
                                  title: 'North-East',
                                  data: snapshot.data.northeast,
                                ),
                                _latLngBoundsText(
                                  title: 'South-West',
                                  data: snapshot.data.southwest,
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _toNextPlace,
        label: const Text('To next place'),
        icon: Icon(Icons.place),
      ),
    );
  }

  Widget _latLngBoundsText({@required LatLng data, String title}) {
    return Text(
      '$title: lat: ${data.latitude}, lng: ${data.longitude}',
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    );
  }

  Future<void> _toNextPlace() async {
    final controller = await _mapController.future;
    final index = _activeIndexBloc.currentState.activeIndex;

    if (index < (googleMapPlaces.length - 1)) {
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          googleMapPlaces.elementAt(index + 1).cameraPosition,
        ),
      );

      _activeIndexBloc..dispatch(SetActiveIndex(index: index + 1));
    } else {
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          googleMapPlaces.elementAt(0).cameraPosition,
        ),
      );
      _activeIndexBloc..dispatch(SetActiveIndex(index: 0));
    }

    final region = await controller.getVisibleRegion();
    _streamController.add(region);
  }

  static const coordinates = <String, LatLng>{
    'Kozak Palace': LatLng(47.83410865, 35.1251964),
    'Hydroelectric Station': LatLng(47.86728682, 35.08997312),
    'Zaporozhian Sich': LatLng(47.85734045, 35.07477421),
  };

  final googleMapPlaces = <GoogleMapPlace>{
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
          snippet: 'Your advertisement could be here',
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
          snippet: 'Your advertisement could be here',
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
          snippet: 'Your advertisement could be here',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    ),
  };
}
