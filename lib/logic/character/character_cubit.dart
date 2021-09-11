import '../../data/models/quote_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/character_model.dart';
import '../../data/repository/character_repository.dart';
import 'character_state.dart';

class CharacterCubit extends Cubit<CharacterStates> {
  CharacterCubit() : super(CharacterInitial());

  List<Character> characters = [];

  static CharacterCubit get(context) =>
      BlocProvider.of<CharacterCubit>(context);

  void getAllCharacters() {
    emit(CharacterLoading());

    CharacterRepository.getAllCharacters().then((characters) {
      this.characters = characters;
      emit(CharacterLoaded());
      print('from character cubit in :: ${this.characters}');
    }).catchError((error) {
      throw '$error';
    });
  }

  List<Quote> characterQuotes = [];
  void getCharacterQuotes(String characterName) {
    CharacterRepository.getCharacterQuotes(characterName)
        .then((characterQoutes) {
      this.characterQuotes = characterQoutes;
      print(characterQoutes.toString());
      emit(CharacterQouteLoaded(quotes: characterQuotes));
    });
  }

  bool isSearching = false;

  startSearch(context) {
    isSearching = true;
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearch));
    emit(ChangeAppBarState());
  }

  stopSearch() {
    isSearching = false;
    clearSearch();
    emit(ChangeAppBarState());
  }

  clearSearch() {
    searchedCharacters = [];
    searchController.clear();
    emit(ChangeAppBarState());
  }

  List<Character> searchedCharacters = [];
  void searchAboutCharacter(String searchedCharacter) async {
    searchedCharacters = characters
        .where((character) =>
            character.name.toLowerCase().contains(searchedCharacter))
        .toList();
    emit(CharacterLoaded());
  }

  TextEditingController searchController = TextEditingController();

  bool get isEmptyTextField => searchController.text.isEmpty;

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
