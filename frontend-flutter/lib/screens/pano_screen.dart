// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/data/tour_repository.dart';
import 'package:frontend_flutter/models.dart';
import 'package:panorama/panorama.dart';

class PanoScreen extends StatefulWidget {
  final TourRepository tourRepository = TourRepository();
  final TourDetail currentTour;
  PanoScreen({Key? key, required this.currentTour}): super(key: key);

  @override
  PanoScreenState createState() => PanoScreenState();
}

class PanoScreenState extends State<PanoScreen> {
  late Future<TourDetail> _currentTour;
  
  @override
  void initState() {
    super.initState();
    _currentTour = widget.tourRepository.fetchTour(widget.currentTour.tourId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _currentTour,
        builder: (context, AsyncSnapshot<TourDetail> snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(snapshot.data!.tourId),
                Text('Count scenes ${snapshot.data!.scenes?.length.toString()}')
              ]
            );
          } else {
            return const Center(child: Text('Loading...'),);
          }
        }
      ),
    );
  } 
}