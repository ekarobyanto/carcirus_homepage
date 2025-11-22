import 'package:flutter/material.dart';
import 'package:flutter_picker_plus/flutter_picker_plus.dart';

class TimePicker extends StatefulWidget {
  final TimeOfDay? selectedTime;
  final ValueChanged<TimeOfDay> onTimeSelected;

  const TimePicker({
    super.key,
    this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    final time = widget.selectedTime ?? TimeOfDay.now();
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute;
    final isPM = time.period == DayPeriod.pm;

    return Picker(
      adapter: PickerDataAdapter<String>(
        pickerData: [
          List.generate(12, (index) => (index + 1).toString().padLeft(2, '0')),
          List.generate(60, (index) => index.toString().padLeft(2, '0')),
          ['AM', 'PM'],
        ],
        isArray: true,
      ),
      delimiter: [
        PickerDelimiter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1),
                    bottom: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: const Text(
                  ':',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
      hideHeader: true,
      selecteds: [hour - 1, minute, isPM ? 1 : 0],
      height: 200,
      itemExtent: 50,
      diameterRatio: 1.5,
      containerColor: Colors.white,
      backgroundColor: Colors.transparent,
      onSelect: (Picker picker, int index, List<int> selecteds) {
        final selectedHour = selecteds[0] + 1;
        final selectedMinute = selecteds[1];
        final selectedPeriod = selecteds[2];

        int hour24 = selectedHour;
        if (selectedPeriod == 1 && selectedHour != 12) {
          hour24 += 12;
        } else if (selectedPeriod == 0 && selectedHour == 12) {
          hour24 = 0;
        }

        final newTime = TimeOfDay(hour: hour24, minute: selectedMinute);
        widget.onTimeSelected(newTime);
      },
      textStyle: Theme.of(context).textTheme.bodyMedium,
      selectedTextStyle: Theme.of(context).textTheme.titleLarge,
      columnFlex: [1, 1, 1],
      looping: false,
      selectionOverlay: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 1),
            bottom: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
      ),
    ).makePicker();
  }
}
