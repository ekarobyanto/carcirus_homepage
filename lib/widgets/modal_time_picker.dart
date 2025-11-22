import 'package:carcirus_homepage/widgets/time_picker.dart';
import 'package:flutter/material.dart';

class ModalTimePicker extends StatefulWidget {
  final TimeOfDay? selectedTime;
  final ValueChanged<TimeOfDay>? onTimeSelected;
  const ModalTimePicker({super.key, this.selectedTime, this.onTimeSelected});

  @override
  State<ModalTimePicker> createState() => _ModalTimePickerState();
}

class _ModalTimePickerState extends State<ModalTimePicker> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    if (widget.selectedTime != null) {
      selectedTime = widget.selectedTime;
    } else {
      selectedTime = TimeOfDay.now();
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
            "Pick-up Time",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          TimePicker(
            selectedTime: selectedTime,
            onTimeSelected: (time) => setState(() {
              selectedTime = time;
            }),
          ),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {
                if (selectedTime != null && widget.onTimeSelected != null) {
                  widget.onTimeSelected!(selectedTime!);
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
