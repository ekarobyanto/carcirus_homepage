import 'package:carcirus_homepage/models/booking_model.dart';
import 'package:carcirus_homepage/providers/booking_provider.dart';
import 'package:carcirus_homepage/screens/car_selection_screen.dart';
import 'package:carcirus_homepage/utils/date_time_formatter.dart';
import 'package:carcirus_homepage/widgets/booking_created_dialog.dart';
import 'package:carcirus_homepage/widgets/booking_exists_dialog.dart';
import 'package:carcirus_homepage/widgets/custom_input_field.dart';
import 'package:carcirus_homepage/widgets/modal_date_picker.dart';
import 'package:carcirus_homepage/widgets/modal_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookCarContainer extends ConsumerStatefulWidget {
  final BookingModel? currentBooking;
  final ValueChanged<BookingModel>? onBookingCreated;
  const BookCarContainer({
    super.key,
    this.currentBooking,
    this.onBookingCreated,
  });

  @override
  ConsumerState<BookCarContainer> createState() => _SelectDateContainerState();
}

class _SelectDateContainerState extends ConsumerState<BookCarContainer> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    if (widget.currentBooking != null) {
      selectedDate = widget.currentBooking!.pickupDate;
      selectedTime = TimeOfDay(
        hour: widget.currentBooking!.pickupTime.hour,
        minute: widget.currentBooking!.pickupTime.minute,
      );
    }
    super.initState();
  }

  void _selectCar() async {
    if (widget.currentBooking != null) {
      showDialog(context: context, builder: (context) => BookingExistDialog());
      return;
    }
    DateTime dateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );
    BookingModel? booking = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarSelectionScreen(pickupDateTime: dateTime),
      ),
    );

    if (booking != null) {
      setState(() {
        widget.onBookingCreated?.call(booking);
      });
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => BookingCreatedDialog(
            onCancel: () => ref.read(bookingProvider.notifier).clearBooking(),
          ),
        );
      }
    }
  }

  void _onPickupDateTapped() {
    if (widget.currentBooking != null) {
      showDialog(context: context, builder: (context) => BookingExistDialog());
      return;
    }
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => ModalDatePicker(
        selectedDate: selectedDate,
        onDateSelected: (date) => setState(() {
          selectedDate = date;
        }),
      ),
    );
  }

  void _onPickupTimeTapped() {
    if (widget.currentBooking != null) {
      showDialog(context: context, builder: (context) => BookingExistDialog());
      return;
    }
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => ModalTimePicker(
        selectedTime: selectedTime,
        onTimeSelected: (time) => setState(() {
          selectedTime = time;
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 35,
            offset: const Offset(0, 5),
            color: Colors.black.withAlpha(20),
          ),
        ],
      ),
      child: Column(
        children: [
          CustomInputField(
            label: "Pick-up Date",
            value: selectedDate != null
                ? formatDate(selectedDate!)
                : "Select a date",
            suffixIcon: Icons.calendar_month_outlined,
            onTap: _onPickupDateTapped,
          ),
          const SizedBox(height: 12),
          CustomInputField(
            label: "Pick-up Time",
            value: selectedTime != null
                ? formatTime(selectedTime!)
                : "Select a time",
            suffixIcon: Icons.access_time_sharp,
            onTap: _onPickupTimeTapped,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: selectedDate != null && selectedTime != null
                  ? _selectCar
                  : null,
              child: Text(
                widget.currentBooking != null ? "See Booking" : "Select My Car",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
