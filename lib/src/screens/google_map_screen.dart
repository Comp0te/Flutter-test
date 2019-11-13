import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/widgets/widgets.dart';
import 'package:flutter_app/src/blocs/blocs.dart';

class GoogleMapScreen extends StatefulWidget with ThemeMixin {
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
    final googleMapPlaces = getGoogleMapPlaces(context);

    return Scaffold(
      drawer: const MainDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
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
                          elevation: 6,
                          color: widget.getTheme(context).accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.all(0),
                          child: Icon(
                            Icons.my_location,
                            size: 30,
                            color:
                                widget.getTheme(context).accentIconTheme.color,
                          ),
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
                              color: widget.getTheme(context).primaryColor,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20,
                                  color:
                                      widget.getColorScheme(context).onSurface,
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ..._latLngBoundsTextArray(
                                  context: context,
                                  title: S.of(context).northEast,
                                  data: snapshot.data.northeast,
                                ),
                                ..._latLngBoundsTextArray(
                                  context: context,
                                  title: S.of(context).southWest,
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
        onPressed: _makeToNextPlace(googleMapPlaces),
        label: Text(
          S.of(context).mapNextPlace,
        ),
        icon: Icon(Icons.place),
      ),
    );
  }

  List<Widget> _latLngBoundsTextArray({
    @required BuildContext context,
    @required LatLng data,
    String title,
  }) {
    return [
      Text(
        '$title:',
        style: widget.getPrimaryTextTheme(context).caption,
      ),
      Text(
        'lat: ${data.latitude}, lng: ${data.longitude}',
        style: widget.getPrimaryTextTheme(context).overline,
      )
    ];
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

  VoidCallback _makeToNextPlace(Set<GoogleMapPlace> googleMapPlaces) =>
      () async {
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
      };
}
