import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/widgets/widgets.dart';
import 'package:flutter_app/src/blocs/blocs.dart';

class GoogleMapScreen extends StatefulWidget {
  @override
  State<GoogleMapScreen> createState() => GoogleMapScreenState();
}

class GoogleMapScreenState extends State<GoogleMapScreen> {
  final _mapController = Completer<GoogleMapController>();
  final _activeIndexBloc = IntValueBloc();
  final _loadedBloc = BoolValueBloc();
  final _streamController = StreamController<LatLngBounds>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () => _mapController.future)
        .asStream()
        .take(1)
        .asyncMap((controller) => controller.getVisibleRegion())
        .listen((latLngBounds) => _streamController.add(latLngBounds));
    _loadedBloc..add(const SetBoolValue(true));
  }

  @override
  void dispose() {
    _streamController?.close();
    _activeIndexBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
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
            bottom: 15,
            left: 20,
            child: SizedBox(
              height: 50,
              width: 50,
              child: BlocBuilder<BoolValueBloc, bool>(
                bloc: _loadedBloc,
                builder: (_, loaded) {
                  return loaded
                      ? RaisedButton(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.all(0),
                          child: Icon(
                            Icons.my_location,
                            color: Colors.white,
                            size: 30,
                          ),
                          color: Colors.blue,
                          onPressed: _toMe,
                        )
                      : const Spinner();
                },
              ),
            ),
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

  Future<void> _toMe() async {
    _loadedBloc..add(const SetBoolValue(false));

    final controller = await _mapController.future;
    final position = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      locationPermissionLevel: GeolocationPermission.locationWhenInUse,
    );

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          position.latitude,
          position.longitude,
        ),
        zoom: 17,
      )),
    );

    final region = await controller.getVisibleRegion();
    _streamController.add(region);

    _loadedBloc..add(const SetBoolValue(true));
  }

  Future<void> _toNextPlace() async {
    final controller = await _mapController.future;
    final index = _activeIndexBloc.state;

    if (index < (googleMapPlaces.length - 1)) {
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          googleMapPlaces.elementAt(index + 1).cameraPosition,
        ),
      );

      _activeIndexBloc..add(SetIntValue(index + 1));
    } else {
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          googleMapPlaces.elementAt(0).cameraPosition,
        ),
      );
      _activeIndexBloc..add(const SetIntValue(0));
    }

    final region = await controller.getVisibleRegion();
    _streamController.add(region);
  }
}
