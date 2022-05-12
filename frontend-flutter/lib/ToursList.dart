import 'package:flutter/material.dart';

import 'TourElement.dart';
import 'models.dart';

class ToursList extends StatelessWidget {
  final List<TourDetail> _toursList;
  final ValueChanged<TourDetail> _handleTourSelected;

  const ToursList({
    Key? key, 
    required List<TourDetail> toursList, 
    required ValueChanged<TourDetail> handleTourSelected
  }): _toursList = toursList, _handleTourSelected = handleTourSelected, super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget body;
    final screenSize = MediaQuery.of(context).size;
    final List<Widget> children = [ 
      for (TourDetail tour in _toursList) 
        TourElement(tour: tour, onTap: _handleTourSelected) 
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