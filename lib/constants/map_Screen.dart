import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

String location;
List<Marker> myMarker = [];

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController newGoogleMapController;
  String latitude, longitude;
  final formKey = GlobalKey<FormState>();
  var geoPosition;
  ////////////////////////////////////////////////////////////////
  Future<Position> getCurrentLocation() async {
    if (geoPosition == null) {
      geoPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = '${geoPosition.latitude}';
      longitude = '${geoPosition.longitude}';
      LatLng current = LatLng(geoPosition.latitude, geoPosition.longitude);
      myMarker = [];
      myMarker.add(
          Marker(markerId: MarkerId(current.toString()), position: current));
      var cor = Coordinates(geoPosition.latitude, geoPosition.longitude);
      final addresses = await Geocoder.local.findAddressesFromCoordinates(cor);
      print("addresses[0].addressLine ${addresses[0].addressLine}");
      location = addresses[0].addressLine;
    }
    return geoPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            //////////////////////////////////////// map
            FutureBuilder(
              future: getCurrentLocation(),
              builder:
                  (BuildContext context, AsyncSnapshot<Position> snapshot) {
                if (ConnectionState.done != snapshot.connectionState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Text('Oh no! Error! ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: Text(''),
                  );
                }
                return Expanded(
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          snapshot.data.latitude, snapshot.data.longitude),
                      zoom: 10.4746,
                    ),
                    indoorViewEnabled: false,
                    myLocationButtonEnabled: true,
                    compassEnabled: true,
                    mapToolbarEnabled: true,
                    zoomGesturesEnabled: true,
                    markers: Set.from(myMarker),
                    onTap: (_) {},
                    onMapCreated: (GoogleMapController controller) async {
                      if (!_controller.isCompleted) {
                        _controller.complete(controller);
                      }
                      newGoogleMapController = controller;
                      newGoogleMapController.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(
                            snapshot.data.latitude, snapshot.data.longitude),
                        zoom: 17.8746,
                      )));
                    },
                  ),
                );
              },
            ),
            /////////////////////////////////////// submit
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        child: RaisedButton(
          onPressed: () {
            if (myMarker.isNotEmpty && location != null) {
              print(location.characters);
              Navigator.of(context).pop(location);
              return location;
            } else if (myMarker.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                content: Text('من فضلك قوم بوضع الدوبس للمكان على الخريطة'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.red,
              ));
            } else if (location == null || location.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                content: Text('حاول مرة أخرى'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.red,
              ));
            }
          },
          child: Text(
            "set",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w800, fontSize: 25),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          color: Color(0xFFFEC40D),
          splashColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
