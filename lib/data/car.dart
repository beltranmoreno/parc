class Car {
  String carName;
  String license;
  String model = "Mazda";
  //Image image;

  Car({required this.carName, required this.license});

  setCarInfo({required String c_name, required String c_license}) {
    carName = c_name;
    license = c_license;
  }

  setCarModel({required String c_model}) {
    this.model = c_model;
  }
}
