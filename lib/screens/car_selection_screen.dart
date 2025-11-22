import 'package:carcirus_homepage/models/booking_model.dart';
import 'package:carcirus_homepage/models/car_model.dart';
import 'package:flutter/material.dart';
import '../data/car_data.dart';
import '../widgets/car_card.dart';

class CarSelectionScreen extends StatefulWidget {
  final DateTime pickupDateTime;

  const CarSelectionScreen({super.key, required this.pickupDateTime});

  @override
  State<CarSelectionScreen> createState() => _CarSelectionScreenState();
}

class _CarSelectionScreenState extends State<CarSelectionScreen> {
  CarModel? _selectedCar;
  @override
  Widget build(BuildContext context) {
    final cars = CarData.getCars();

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.white,
        width: double.maxFinite,
        child: ElevatedButton(
          onPressed: _selectedCar != null
              ? () => Navigator.of(context).pop(
                  BookingModel(
                    car: _selectedCar!,
                    pickupDate: widget.pickupDateTime,
                    pickupTime: widget.pickupDateTime,
                  ),
                )
              : null,
          child: Text("Book Now"),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Pick a Car'),
        centerTitle: true,
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: cars.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          var car = cars[index];
          return CarCard(
            car: car,
            isSelected: _selectedCar?.id == car.id,
            onTap: () {
              setState(() {
                if (_selectedCar?.id == car.id) {
                  _selectedCar = null;
                  return;
                }
                _selectedCar = car;
              });
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      ),
    );
  }
}
