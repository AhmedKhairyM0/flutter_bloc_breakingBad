import 'package:flutter/material.dart';

import 'core/color_palette.dart';
import 'data/data_source/remote/character_web_services.dart';
import 'route.dart';

void main() async {
  CharacterWebServices(); // configuration for characters web services
  runApp(BreakingBadApp());
}

class BreakingBadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: ColorPalette.kPrimaryColor,
      ),
      initialRoute: RouteGenerator.characters,
      onGenerateRoute: RouteGenerator.onGenerate,
    );
  }
}
