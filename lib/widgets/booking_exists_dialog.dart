import 'package:carcirus_homepage/gen/assets.gen.dart';
import 'package:carcirus_homepage/theme.dart';
import 'package:flutter/material.dart';

class BookingExistDialog extends StatelessWidget {
  const BookingExistDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
              Assets.lib.assets.images.carWarnVector.path,
              height: 40,
            ),
          ),
          Text(
            "You have book or active car rental",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          Text(
            "Please complete your current rental before booking a new one",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        SizedBox(
          width: double.maxFinite,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Back", style: Theme.of(context).textTheme.titleLarge),
          ),
        ),
      ],
    );
  }
}
