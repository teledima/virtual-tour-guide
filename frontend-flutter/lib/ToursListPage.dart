import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/PanoPage.dart';
import 'package:http/http.dart' as http;

import './models.dart';
import 'ToursList.dart';

class ToursListPage extends StatefulWidget {
  const ToursListPage({Key? key}): super(key: key);

  @override
  _ToursListPageState createState() => _ToursListPageState();
}

class _ToursListPageState extends State<ToursListPage> {
  late Future<http.Response> _toursListFetchResult;
  late List<TourDetail> _toursList;
  TourDetail? _currentTour;

  Future<http.Response> _getListTour() async {
    final response = await http.get(Uri.parse('http://192.168.1.44:8080/tours/all'));
    
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        _toursList = [for (var tour in json) TourDetail.fromJson(tour)];
      });

      return response;
    } else {
      throw Exception("Failed to load tours list");
    }
  }

  void _handleTourSelected(TourDetail tour) {
    setState(() {
      _currentTour = tour;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentTour = null;
    _toursListFetchResult = _getListTour();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        pages: [
          MaterialPage(
            key: const ValueKey('ListTourPage'),
            child: FutureBuilder(
              future: _toursListFetchResult, 
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ToursList(toursList: _toursList, handleTourSelected: _handleTourSelected);
                } else {
                  return const Text("Loading...");
                }
              }
            )
          ),
          if (_currentTour != null)
            MaterialPage(
              key: ValueKey(_currentTour),
              child: PanoPage(tourId: _currentTour!.tourId)
            )
        ],
        onPopPage: (route, result) { 
          if (!route.didPop(result)) return false;

          setState(() {
            _currentTour = null;
          });

          return true;
        },
      )  
    );
  }
}
