// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/models.dart';

class TourCard extends StatelessWidget {
  final TourDetail tour;
  final ValueChanged<TourDetail> onTourSelected;

  Image get thumbnail {
    if (tour.defaultScene?.thumbnail == null) {
      return Image.asset('assets/image_not_found.jpeg', fit: BoxFit.contain);
    } else {
      return Image.network('http://192.168.1.44:8080/images/${tour.defaultScene!.thumbnail}');
    }
  }

  const TourCard({Key? key, required this.tour, required this.onTourSelected}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () => onTourSelected(tour), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Text(tour.title, style: const TextStyle(fontWeight: FontWeight.bold))),
              const SizedBox(height: 8),
              Expanded(flex: 1, child: thumbnail)
            ]
          )
        ),
      )
    );
  }
}
