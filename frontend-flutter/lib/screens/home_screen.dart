// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/data/tour_repository.dart';
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/screens/add_tour_dialog.dart';
import 'package:frontend_flutter/widgets/tour_card.dart';

class HomeScreen extends StatefulWidget {
  final TourRepository tourRepository = TourRepository();
  final Function(TourDetail) onTourSelected;
  
  HomeScreen({Key? key, required this.onTourSelected}): super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<TourDetail>> _listTours;

  void onAddTour() async {
    final newTour = await showDialog<TourDetail>(
      context: context, 
      builder: (_) => AddTourDialog()
    );
    if (newTour != null) { 
      final result = await widget.tourRepository.addTour(newTour);
      if (result.acknowledged) {
        setState(() => _listTours = widget.tourRepository.fetchTours());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _listTours = widget.tourRepository.fetchTours();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Виртуальный экскурсовод'), 
        actions: [
          // TODO
          TextButton(style: style, onPressed: () => print('Exit'), child: const Text('Выход'))
        ],
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: _listTours,
        builder: (context, AsyncSnapshot<List<TourDetail>> snapshot) {
          if (snapshot.hasData) {
            final List<Widget> children = [ 
              for (TourDetail tour in snapshot.data!) 
                TourCard(tour: tour, onTourSelected: widget.onTourSelected) 
            ];
            return GridView.extent(maxCrossAxisExtent: 360, children: children,);
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: Text('Loading...'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddTour,
        child: const Icon(Icons.add, size: 32,),
      ),
    );
  }
}
