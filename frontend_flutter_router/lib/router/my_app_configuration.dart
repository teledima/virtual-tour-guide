import 'package:frontend_flutter_router/models.dart';

class MyAppConfiguration {
  final bool bootstraped;
  final bool unknown;
  final Item? detail;

  MyAppConfiguration.bootstrap()
    : bootstraped = false,
      unknown = false,
      detail = null;

  MyAppConfiguration.home()
    : bootstraped = true,
      unknown = false, 
      detail = null;
      
  MyAppConfiguration.detail(Item value)
    : bootstraped = true,
      unknown = false,
      detail = value;
  
  MyAppConfiguration.unknown()
    : bootstraped = true,
      unknown = true,
      detail = null;

  bool get isHome => bootstraped == true && unknown == false && detail == null;
  bool get isDetail => unknown == false && detail != null;
  bool get isUnknown => unknown == true;
  bool get isBootstraped => bootstraped == true;
}