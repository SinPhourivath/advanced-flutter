import 'package:week4/model/ride_pref/ride_pref.dart';
import 'package:week4/repository/ride_repository.dart';

import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static RidesService? _instance;

  final RideRepository repository;

  RidesService._internal(this.repository);

  static void initialize(RideRepository repository) {
    if (_instance == null) {
      _instance = RidesService._internal(repository);
    } else {
      throw Exception("RidesService is already initialized");
    }
  }

  static RidesService get instance {
    if (_instance == null) {
      throw Exception("RidesService is not initialized. Use initalize() first");
    }
    return _instance!;
  }

  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  List<Ride> getRidesFor(RidePreference preferences, RideFilter? filter) {
    return repository.getRides(preferences, filter);
  }
}

class RideFilter {
  bool acceptPets;

  RideFilter({required this.acceptPets});
}
