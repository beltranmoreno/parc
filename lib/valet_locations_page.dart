import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart'
    show LatLng;
import 'package:location/location.dart';

class UserValetLocation extends StatefulWidget {
  const UserValetLocation({Key? key, required this.buildContext})
      : super(key: key);

  final BuildContext buildContext;
  @override
  _UserValetLocationState createState() => _UserValetLocationState();
}

class _UserValetLocationState extends State<UserValetLocation> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(25.7179, -80.2746);
  LatLng _initialcameraposition = LatLng(25.7179, -80.2746);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    location.onLocationChanged.listen((l) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  late geolocator.Position _currentPos;

  late LocationData _currentPosition;
  var location = Location();

  @override
  void initState() {
    super.initState();
    getLoc();
    location = Location();
  }

  _getCurrentLocation() {
    geolocator.Geolocator.getCurrentPosition(
            desiredAccuracy: geolocator.LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((geolocator.Position position) {
      setState(() {
        _currentPos = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  /*static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );*/

  /*static final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Locations"),
        backgroundColor: Color(0xff66867B),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        compassEnabled: true,
        initialCameraPosition:
            CameraPosition(target: _initialcameraposition, zoom: 15.0),
        onMapCreated: _onMapCreated,
      ),
    );
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition =
        LatLng(_currentPosition.latitude!, _currentPosition.longitude!);
    location.onLocationChanged.listen((LocationData currentLocation) {
      //print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition =
            LatLng(_currentPosition.latitude!, _currentPosition.longitude!);

        DateTime now = DateTime.now();
        /*_dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
        _getAddress(_currentPosition.latitude, _currentPosition.longitude)
            .then((value) {
          setState(() {
            _address = "${value.first.addressLine}";
          });
        });*/
      });
    });
  }
}
