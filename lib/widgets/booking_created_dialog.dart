import 'package:carcirus_homepage/gen/assets.gen.dart';
import 'package:carcirus_homepage/theme.dart';
import 'package:flutter/material.dart';

class BookingCreatedDialog extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onSeeBooking;
  const BookingCreatedDialog({super.key, this.onCancel, this.onSeeBooking});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primary.withAlpha(30),
            ),
            child: Image.asset(
              Assets.lib.assets.images.checkVector.path,
              height: 40,
            ),
          ),
          Text(
            "Your booking has created!",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            "Our team will checking available car and assign it to you",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        Row(
          spacing: 4,
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  onCancel?.call();
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("See Booking"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
