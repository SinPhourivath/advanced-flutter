import 'package:week4/model/ride_pref/ride_pref.dart';

import '../model/ride/ride.dart';
import '../service/rides_service.dart';

abstract class RideRepository {
  List<Ride> getRides(RidePreference preferences, RideFilter? filter);
}
