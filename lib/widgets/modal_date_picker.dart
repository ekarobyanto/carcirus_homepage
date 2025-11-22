import 'package:carcirus_homepage/widgets/custom_date_picker.dart';
import 'package:flutter/material.dart';

class ModalDatePicker extends StatefulWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime>? onDateSelected;
  const ModalDatePicker({super.key, this.selectedDate, this.onDateSelected});

  @override
  State<ModalDatePicker> createState() => _ModalDatePickerState();
}

class _ModalDatePickerState extends State<ModalDatePicker> {
  DateTime? selectedDate;
  VoidCallback? onDateSelected;

  @override
  void initState() {
    if (widget.selectedDate != null) {
      selectedDate = widget.selectedDate;
    } else {
      selectedDate = DateTime.now();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
          Text(
            "Pick-up Date",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.55,
            ),
            child: CustomDatePicker(
              selectedDate: selectedDate,
              onDateSelected: (date) => setState(() {
                selectedDate = DateTime(date.year, date.month, date.day);
              }),
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                if (selectedDate != null && widget.onDateSelected != null) {
                  widget.onDateSelected!(selectedDate!);
                  Navigator.pop(context);
                }
              },
              child: const Text("Apply"),
            ),
          ),
        ],
      ),
    );
  }
}
