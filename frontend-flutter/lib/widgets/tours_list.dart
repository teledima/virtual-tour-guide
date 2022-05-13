// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/models.dart';
import 'tour_card.dart';

class ToursList extends StatelessWidget {
  final List<TourDetail> toursList;
  final Function(TourDetail) onTourSelected;

  const ToursList({Key? key, required this.toursList, required this.onTourSelected}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget body;
    final screenSize = MediaQuery.of(context).size;
    final List<Widget> children = [ 
      for (TourDetail tour in toursList) 
        TourCard(tour: tour, onTourSelected: onTourSelected) 
    ];

    if (screenSize.width > 720) {
      body = GridView.count(
        crossAxisCount: 3, 
        children: children
      );
    } else {
      body = ListView(
        children: children
      );
    }
    return body;
  }
}