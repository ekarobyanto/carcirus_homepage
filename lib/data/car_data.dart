import 'package:carcirus_homepage/gen/assets.gen.dart';

import '../models/car_model.dart';

class CarData {
  static List<CarModel> getCars() {
    return [
      CarModel(
        id: 1,
        name: 'Nissan Sentra Or Similar',
        type: 'Economic',
        pricePerWeek: 300,
        imagePath: Assets.lib.assets.images.blackNissan.path,
      ),
      CarModel(
        id: 2,
        name: 'Toyota Prius Or Similar',
        type: 'Hybrid',
        pricePerWeek: 350,
        imagePath: Assets.lib.assets.images.whiteToyota.path,
      ),
      CarModel(
        id: 3,
        name: 'Nissan Pathfinder Or Similar',
        type: 'SUV',
        pricePerWeek: 400,
        imagePath: Assets.lib.assets.images.whiteNissan.path,
      ),
    ];
  }
}
