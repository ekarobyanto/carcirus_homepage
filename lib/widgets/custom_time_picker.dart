import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  final DateTime? selectedTime;
  final ValueChanged<DateTime> onTimeSelected;

  const CustomTimePicker({
    super.key,
    this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late int selectedHour;
  late int selectedMinute;
  late String selectedPeriod;

  @override
  void initState() {
    super.initState();
    _initializeTime();
  }

  @override
  void didUpdateWidget(CustomTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedTime != widget.selectedTime) {
      _initializeTime();
    }
  }

  void _initializeTime() {
    final time = widget.selectedTime ?? DateTime.now();
    final hour = time.hour;

    if (hour == 0) {
      selectedHour = 12;
      selectedPeriod = 'AM';
    } else if (hour < 12) {
      selectedHour = hour;
      selectedPeriod = 'AM';
    } else if (hour == 12) {
      selectedHour = 12;
      selectedPeriod = 'PM';
    } else {
      selectedHour = hour - 12;
      selectedPeriod = 'PM';
    }

    selectedMinute = time.minute;
  }

  void _notifyTimeChanged() {
    int hour24 = selectedHour;
    if (selectedPeriod == 'PM' && selectedHour != 12) {
      hour24 += 12;
    } else if (selectedPeriod == 'AM' && selectedHour == 12) {
      hour24 = 0;
    }

    final newTime = DateTime(0, 1, 1, hour24, selectedMinute);
    widget.onTimeSelected(newTime);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Hour picker
        _buildTimePicker(
          value: selectedHour,
          onChanged: (value) {
            setState(() {
              selectedHour = value;
            });
            _notifyTimeChanged();
          },
          min: 1,
          max: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(':', style: Theme.of(context).textTheme.displayLarge),
        ),
        // Minute picker
        _buildTimePicker(
          value: selectedMinute,
          onChanged: (value) {
            setState(() {
              selectedMinute = value;
            });
            _notifyTimeChanged();
          },
          min: 0,
          max: 59,
        ),
        const SizedBox(width: 24),
        // AM/PM toggle
        Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedPeriod = 'AM';
                });
                _notifyTimeChanged();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: selectedPeriod == 'AM'
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'AM',
                  style: TextStyle(
                    color: selectedPeriod == 'AM' ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedPeriod = 'PM';
                });
                _notifyTimeChanged();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: selectedPeriod == 'PM'
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'PM',
                  style: TextStyle(
                    color: selectedPeriod == 'PM' ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimePicker({
    required int value,
    required ValueChanged<int> onChanged,
    required int min,
    required int max,
  }) {
    return Container(
      width: 80,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_up),
            onPressed: () {
              if (value < max) {
                onChanged(value + 1);
              } else {
                onChanged(min);
              }
            },
          ),
          Text(
            value.toString().padLeft(2, '0'),
            style: Theme.of(context).textTheme.displayMedium,
          ),
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down),
            onPressed: () {
              if (value > min) {
                onChanged(value - 1);
              } else {
                onChanged(max);
              }
            },
          ),
        ],
      ),
    );
  }
}
