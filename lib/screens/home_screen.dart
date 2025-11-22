import 'package:carcirus_homepage/gen/assets.gen.dart';
import 'package:carcirus_homepage/providers/booking_provider.dart';
import 'package:carcirus_homepage/theme.dart';
import 'package:carcirus_homepage/widgets/book_car_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _features = [
    {
      "image": Assets.lib.assets.images.cashVector.path,
      "title": "Start with \$300/week",
    },
    {
      "image": Assets.lib.assets.images.handVector.path,
      "title": "Reasonable price",
    },
    {
      "image": Assets.lib.assets.images.carInsuranceVector.path,
      "title": "Well maintained cars",
    },
    {
      "image": Assets.lib.assets.images.rentalVector.path,
      "title": "Drive with unlimited mileage",
    },
  ];

  final List<Map<String, dynamic>> _steps = [
    {
      "title": "Find your ride",
      "description":
          "Set your pick-up date & time. Tap ‘Book Now’ to make a reservation for available car.",
    },
    {
      "title": "Fill the submission form",
      "description":
          "You can fill the form submission and we are going to make sure you are provided by our services.",
    },
  ];

  final List<Map<String, dynamic>> _menus = [
    {
      "label": "Rent",
      "icon": Icons.car_rental_outlined,
      "activeIcon": Icons.car_rental,
    },
    {
      "label": "My Car",
      "icon": Icons.directions_car_outlined,
      "activeIcon": Icons.directions_car,
    },
    {
      "label": "My Bills",
      "icon": Icons.receipt_outlined,
      "activeIcon": Icons.receipt,
    },
    {
      "label": "Profile",
      "icon": Icons.person_2_outlined,
      "activeIcon": Icons.person_2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentBooking = ref.watch(bookingProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: MediaQuery.sizeOf(context).height * 0.35,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Assets.lib.assets.images.logo.image(height: 34, width: 89),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Looking for a car rental?",
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Book now and enjoy 10% off your first week's rental!",
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    BookCarContainer(
                      currentBooking: currentBooking,
                      onBookingCreated: (booking) {
                        ref
                            .read(bookingProvider.notifier)
                            .createBooking(booking);
                      },
                    ),
                    Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Why ",
                            style: Theme.of(context).textTheme.headlineMedium,
                            children: [
                              TextSpan(
                                text: "Carcirus?",
                                style: Theme.of(context).textTheme.displaySmall
                                    ?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount: _features.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2.5,
                              ),
                          itemBuilder: (context, index) {
                            var feature = _features[index];
                            return _buildFeatureItem(
                              feature['image'] as String,
                              feature['title'] as String,
                            );
                          },
                        ),
                      ],
                    ),
                    Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How To Rent a Car",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(
                          height: 250,
                          child: ListView.separated(
                            itemCount: _steps.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, idx) => _buildStepCard(
                              number: (idx + 1).toString(),
                              title: _steps[idx]['title'] as String,
                              description: _steps[idx]['description'] as String,
                            ),
                            separatorBuilder: (ctx, _) => SizedBox(width: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: _menus
            .map(
              (menu) => BottomNavigationBarItem(
                icon: Icon(menu['icon'] as IconData),
                activeIcon: Icon(menu['activeIcon'] as IconData),
                label: menu['label'] as String,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildFeatureItem(String imagePath, String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(imagePath, fit: BoxFit.contain, width: 50, height: 50),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepCard({
    required String number,
    required String title,
    required String description,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 250),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.grey),
        ),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(360),
              ),
              child: Center(
                child: Text(
                  number,
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall?.copyWith(color: Colors.white),
                ),
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              description,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
