import 'car_model.dart';

class BookingModel {
  final CarModel car;
  final DateTime pickupDate;
  final DateTime pickupTime;
  final String? pickupLocation;

  BookingModel({
    required this.car,
    required this.pickupDate,
    required this.pickupTime,
    this.pickupLocation,
  });
}
