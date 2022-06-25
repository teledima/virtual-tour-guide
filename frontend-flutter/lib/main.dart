// Flutter
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:camera/camera.dart';
// Application
import 'package:frontend_flutter/router/login_router/login_route_information_parser.dart';
import 'package:frontend_flutter/router/login_router/login_router_delegate.dart';

Future main() async{
  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();

  late  List<CameraDescription> cameras;
  try {
    cameras = await availableCameras();
    GetIt.I.registerSingleton<CameraDescription>(cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back));
  } on CameraException {
    cameras = [];
  }
  
  runApp(App());
}

class App extends StatelessWidget {
  final _delegatorLogin = LoginRouterDelegate();
  final _parserLogin = LoginRouteInformationParser();

  App({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _parserLogin, 
      routerDelegate: _delegatorLogin
    );
  }
}
