import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/booking_model.dart';

final bookingProvider = StateNotifierProvider<BookingNotifier, BookingModel?>(
  (ref) => BookingNotifier(),
);

class BookingNotifier extends StateNotifier<BookingModel?> {
  BookingNotifier() : super(null);

  void createBooking(BookingModel booking) {
    state = booking;
  }

  void clearBooking() {
    state = null;
  }
}
