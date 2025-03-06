import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../../utils/date_time_util.dart';
import '../../../widgets/display/bla_divider.dart';
import '../../../widgets/inputs/bla_location_picker.dart';
import './ride_pref_tile.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null; // User must select both departure and arrival locations
      arrival = null;
      departureDate = DateTime.now(); // Default: today
      requestedSeats = 1; // Default: 1 seat
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void onDeparturePressed() async {
    // Wait for BlaLocationPicker
    Location? selectedLocation = await Navigator.of(context).push<Location>(
        MaterialPageRoute(builder: (ctx) => BlaLocationPicker()));

    // Update departure location
    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onArrivalPressed() async {
    // Wait for BlaLocationPicker
    Location? selectedLocation = await Navigator.of(context).push<Location>(
        MaterialPageRoute(builder: (ctx) => BlaLocationPicker()));

    // Update arrival location
    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  void onSwapLocationPressed() {
    // Allow swapping only if both locations are selected
    if (departure != null && arrival != null) {
      Location tmp = departure!;
      setState(() {
        departure = arrival;
        arrival = tmp;
      });
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get departureLabel =>
      departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get seatLabel => requestedSeats.toString();

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RidePrefTile(
            text: departureLabel,
            leadingIcon: Icons.circle_outlined,
            onPressed: onDeparturePressed,
            trailingIconButton: IconButton(
              onPressed: onSwapLocationPressed,
              icon: Icon(Icons.swap_vert),
            ),
          ),
          const BlaDivider(horizontalPadding: BlaSpacings.xl),
          RidePrefTile(
              text: arrivalLabel,
              leadingIcon: Icons.circle_outlined,
              onPressed: onArrivalPressed),
          const BlaDivider(horizontalPadding: BlaSpacings.xl),
          RidePrefTile(
              text: dateLabel,
              leadingIcon: Icons.calendar_month_outlined,
              onPressed: () {}),
          const BlaDivider(horizontalPadding: BlaSpacings.xl),
          RidePrefTile(
              text: seatLabel,
              leadingIcon: Icons.person_outline,
              onPressed: () {}),
          // Bla button is not used here becuase it doesn't fit correctly
          TextButton(
            onPressed: () {
              print("Search button pressed!");
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: BlaSpacings.m),
              decoration: BoxDecoration(
                color: BlaColors.primary,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(BlaSpacings.radius),
                ),
              ),
              child: Text(
                "Search",
                style: BlaTextStyles.button.copyWith(color: BlaColors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ]);
  }
}
