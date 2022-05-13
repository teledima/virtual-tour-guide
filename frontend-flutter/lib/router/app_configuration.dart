import 'package:frontend_flutter/models.dart';

class AppConfiguration {
  TourDetail? currentTour;

  AppConfiguration.home()
    : currentTour = null;
  
  AppConfiguration.pano(TourDetail value)
    : currentTour = value;

  bool get isHomePage => currentTour == null;
  bool get isPanoPage => currentTour != null;
}