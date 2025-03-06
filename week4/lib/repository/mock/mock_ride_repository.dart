import 'package:week4/model/ride/ride.dart';
import 'package:week4/model/user/user.dart';
import 'package:week4/repository/ride_repository.dart';

import '../../model/ride/locations.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';

class MockRideRepository extends RideRepository {
  final Location siemReap =
      Location(name: "Siem Reap", country: Country.cambodia);
  final Location battambang =
      Location(name: "Battambang", country: Country.cambodia);

  User kannika = User(
    firstName: "Kannika",
    lastName: "Kak",
    email: "kannika.smith@example.com",
    phone: "123-456-7890",
    profilePicture: "path/to/profile_picture.png",
    verifiedProfile: true,
  );

  User chaylim = User(
    firstName: "Chaylim",
    lastName: "Heng",
    email: "chaylim.doe@example.com",
    phone: "987-654-3210",
    profilePicture: "path/to/chaylim_picture.png",
    verifiedProfile: false,
  );

  User mengtech = User(
    firstName: "Mengtech",
    lastName: "Hout",
    email: "mengtech.lee@example.com",
    phone: "456-789-0123",
    profilePicture: "path/to/mengtech_picture.png",
    verifiedProfile: true,
  );

  User limhao = User(
    firstName: "Limhao",
    lastName: "Chan",
    email: "limhao.chan@example.com",
    phone: "321-654-0987",
    profilePicture: "path/to/limhao_picture.png",
    verifiedProfile: false,
  );

  User sovanda = User(
    firstName: "Sovanda",
    lastName: "Kim",
    email: "sovanda.kim@example.com",
    phone: "789-012-3456",
    profilePicture: "path/to/sovanda_picture.png",
    verifiedProfile: true,
  );

  List<Ride> _rides = [];

  MockRideRepository() {
    _rides = [
      Ride(
        departureLocation: battambang,
        departureDate: DateTime.now().copyWith(hour: 5, minute: 30),
        arrivalLocation: siemReap,
        arrivalDateTime:
            DateTime.now().copyWith(hour: 7, minute: 30), // 2-hour duration
        driver: kannika,
        availableSeats: 2,
        pricePerSeat: 10,
      ),
      Ride(
        departureLocation: battambang,
        departureDate: DateTime.now().copyWith(hour: 20, minute: 0),
        arrivalLocation: siemReap,
        arrivalDateTime:
            DateTime.now().copyWith(hour: 22, minute: 0), // 2-hour duration
        driver: chaylim,
        availableSeats: 0,
        pricePerSeat: 10,
      ),
      Ride(
        departureLocation: battambang,
        departureDate: DateTime.now().copyWith(hour: 5, minute: 0),
        arrivalLocation: siemReap,
        arrivalDateTime:
            DateTime.now().copyWith(hour: 8, minute: 0), // 3-hour duration
        driver: mengtech,
        availableSeats: 1,
        pricePerSeat: 10,
      ),
      Ride(
        departureLocation: battambang,
        departureDate: DateTime.now().copyWith(hour: 20, minute: 0),
        arrivalLocation: siemReap,
        arrivalDateTime:
            DateTime.now().copyWith(hour: 22, minute: 0), // 2-hour duration
        driver: limhao,
        availableSeats: 2,
        pricePerSeat: 10,
      ),
      Ride(
        departureLocation: battambang,
        departureDate: DateTime.now().copyWith(hour: 5, minute: 0),
        arrivalLocation: siemReap,
        arrivalDateTime:
            DateTime.now().copyWith(hour: 8, minute: 0), // 3-hour duration
        driver: sovanda,
        availableSeats: 1,
        pricePerSeat: 10,
      )
    ];
  }

  @override
  List<Ride> getRides(RidePreference preference, RideFilter? filter) {
    return _rides.where((ride) {
      return ride.departureLocation ==
              preference.departure && // Match departure location
          ride.arrivalLocation ==
              preference.arrival && // Match arrival location
          ride.availableSeats > 0 && // There are available seats
          (filter == null || filter.acceptPets); // Accept pets or not specified
    }).toList();
  }
}
