import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/models/character_model.dart';
import 'logic/character/character_cubit.dart';
import 'presentation/screens/character_details_screen.dart';
import 'presentation/screens/characters_screen.dart';

class RouteGenerator {
  static const String characters = '/';
  static const String characterDetails = '/character-details';

  static Route onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case characters:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CharacterCubit(),
            child: CharactersScreen(),
          ),
        );

      case characterDetails:
        var character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                CharacterCubit()..getCharacterQuotes(character.name),
            child: CharacterDetailsScreen(character: character),
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() => MaterialPageRoute(
        builder: (BuildContext context) => Scaffold(
          body: Center(child: Text('Error Screen')),
        ),
      );
}
