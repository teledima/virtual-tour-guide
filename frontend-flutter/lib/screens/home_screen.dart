// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/data/tour_repository.dart';
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/widgets/tours_list.dart';

class HomeScreen extends StatefulWidget {
  final TourRepository tourRepository = TourRepository();
  final Function(TourDetail) onTourSelected;
  
  HomeScreen({Key? key, required this.onTourSelected}): super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<TourDetail>> _listTours;

  @override
  void initState() {
    super.initState();
    _listTours = widget.tourRepository.fetchTours();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _listTours,
        builder: (context, AsyncSnapshot<List<TourDetail>> snapshot) {
          if (snapshot.hasData) {
            return ToursList(toursList: snapshot.data!, onTourSelected: widget.onTourSelected);
          } else {
            return const Center(child: Text('Loading...'));
          }
        },
      )
    );
  }
}