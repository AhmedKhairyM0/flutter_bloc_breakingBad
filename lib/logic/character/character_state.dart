
import '../../data/models/quote_model.dart';


abstract class CharacterStates {}

class CharacterInitial extends CharacterStates {}

class CharacterLoading extends CharacterStates {}

class CharacterLoaded extends CharacterStates {}

class CharacterQouteLoaded extends CharacterStates {
  List<Quote> quotes;
  CharacterQouteLoaded({
    required this.quotes,
  });
}

class SearchedCharacterLoaded extends CharacterStates {}

class ChangeAppBarState extends CharacterStates {}
