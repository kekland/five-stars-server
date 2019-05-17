class Location {
  Location({this.latitude, this.longitude, this.name});
  
  double latitude;
  double longitude;

  String name;
}

enum VehicleType {
  autoTransporter,
  onboard,
  jumbo,
  closed,
  isotherm,
  isothermRefrigerated,
  containerTransporter,
  mega,
  open,
  refrigerator,
  dumpTruck,
  tent,
  trawl,
  allMetal,
  curtain,
}
