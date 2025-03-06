import 'package:flutter/material.dart';
import 'package:week4/screens/rides/widgets/ride_pref_bar.dart';
import 'package:week4/screens/rides/widgets/ride_pref_modal.dart';

import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/ride_prefs_service.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';

import '../../utils/animations_util.dart';
import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///
class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  RidePreference get currentPreference =>
      RidePrefService.instance.currentPreference!;

  // // Kind of work with below setState
  // RidePreference currentPreference =
  //     RidePrefService.instance.currentPreference!;

  List<Ride> get matchingRides => RidesService.instance
      .getRidesFor(currentPreference, null); // TODO: No filter yet

  void onBackPressed() {
    Navigator.of(context).pop(); //  Back to the previous view
  }

  void onPreferencePressed() async {
    RidePreference? newPreference = await Navigator.of(context).push(
        AnimationUtils.createBottomToTopRoute(
            RidePrefModal(initialPreference: currentPreference)));

    if (newPreference != null) {
      RidePrefService.instance.setCurrentPreference(newPreference);
      setState(() {});
    }

    // // If I create currentPreference as computed property
    // if (newPreference != null) {
    //   setState(() {
    //     currentPreference = newPreference;
    //   });
    // }
  }

  void onFilterPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
      child: Column(
        children: [
          // Top search Search bar
          RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: onBackPressed,
              onPreferencePressed: onPreferencePressed,
              onFilterPressed: onFilterPressed),

          Expanded(
            child: ListView.builder(
              itemCount: matchingRides.length,
              itemBuilder: (ctx, index) => RideTile(
                ride: matchingRides[index],
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
