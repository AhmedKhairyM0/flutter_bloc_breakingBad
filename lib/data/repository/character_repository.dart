import '../data_source/remote/character_web_services.dart';
import '../models/character_model.dart';
import '../models/quote_model.dart';

class CharacterRepository {
  static Future<List<Character>> getAllCharacters() async {
    var characters = await CharacterWebServices.getAllCharacters();
    var c =
        characters.map((character) => Character.fromMap(character)).toList();
    // print('from character repo: $c');
    return c;
  }

  static Future<List<Quote>> getCharacterQuotes(String characterName) async {
    var qoutes = await CharacterWebServices.getCharacterQuotes(characterName);
    // print('from character repo: $qoutes');

    return qoutes.map((quote) => Quote.fromMap(quote)).toList();
  }
}
