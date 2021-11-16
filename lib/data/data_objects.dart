import 'dart:core';

class UserSession {
  String name;
  double sessionID;
  String checkInTime = '0:00';
  UserCar userCar = UserCar(carName: "placeName", license: "placeLicense");
  LocationInfo location =
      LocationInfo(name: "placeName", expLocation: "placeLocation");

  UserSession({required this.name, required this.sessionID});
  setCarInfo({required String c_name, required String c_license}) {
    userCar.carName = c_name;
    userCar.license = c_license;
  }

  String getCarName() {
    return userCar.carName;
  }

  String getCarLicense() {
    return userCar.license;
  }

  String getCarModel() {
    return userCar.model;
  }

  setLocationInfo({required String c_name, required String c_location}) {
    location.name = c_name;
    location.expLocation = c_location;
  }

  String getLocationName() {
    return location.name;
  }

  String getLocationPlace() {
    return location.expLocation;
  }

  String getLocationLat() {
    return location.latitute.toString();
  }

  String getLocationLon() {
    return location.longitude.toString();
  }
}

class UserCar {
  String carName;
  String license;
  String model = "Mazda";
  //Image image;

  UserCar({required this.carName, required this.license});

  setCarInfo({required String c_name, required String c_license}) {
    carName = c_name;
    license = c_license;
  }

  setCarModel({required String c_model}) {
    this.model = c_model;
  }
}

class ValetPersonInfo {
  String name;
  String phoneNumber;
  // Image image = Image(image: );

  ValetPersonInfo({required this.name, required this.phoneNumber});
}

class LocationInfo {
  String name;
  String expLocation;
  double latitute = 0;
  double longitude = 0;

  LocationInfo({required this.name, required this.expLocation});
  setLatLon({required double lat, required double lon}) {
    latitute = lat;
    longitude = lon;
  }
}
