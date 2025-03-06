import 'package:week4/repository/locations_repository.dart';

import '../model/ride/locations.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  static LocationsService? _instance;

  final LocationsRepository repository;

  LocationsService._internal(this.repository);

  static void initialize(LocationsRepository repository) {
    if (_instance == null) {
      _instance = LocationsService._internal(repository);
    } else {
      throw Exception("LocationsService is already initialized");
    }
  }

  static LocationsService get instance {
    if (_instance == null) {
      throw Exception(
          "LocationsService is not initialized. Use initalize() first");
    }
    return _instance!;
  }

  List<Location> getLocations() {
    return repository.getLocations();
  }

  List<Location> searchForLocations(String text) {
    return repository
        .getLocations()
        .where((location) =>
            location.name.toUpperCase().contains(text.toUpperCase()))
        .toList();
  }
}
