import 'package:flutter/material.dart';
import 'package:wasteagram/screens/list_detail_screen.dart';
import 'package:wasteagram/screens/waste_entry_form.dart';
import 'package:wasteagram/screens/waste_list.dart';

class App extends StatelessWidget {
  
  final String title;

  const App({Key? key, required this.title}) : super(key: key);

 static final routes = {
    '/': (context) => CameraScreen(),
    'WasteEntryForm': (context) => WasteEntryForm(image),
    'WasteListDetails': (context) => ListDetailScreen(imageURL!,date!,quantity!,latitude!,longtitude!),
  };

  static get image => null;
  static String? get date => null;
  static String? get imageURL => null;
  static String? get latitude => null;
  static String? get longtitude => null;
  static String? get quantity => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        routes: routes,
     );
  }
}