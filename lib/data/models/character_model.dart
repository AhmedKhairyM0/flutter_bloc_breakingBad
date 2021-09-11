import 'dart:convert';

class Character {
  int charId;
  String name;
  String birthday;
  List<String> occupation;
  String img;
  String status;
  String nickname;
  List<int> appearance;
  String portrayed;
  String category;
  List<int> betterCallSaulAppearance;

  Character({
    required this.charId,
    required this.name,
    required this.birthday,
    required this.occupation,
    required this.img,
    required this.status,
    required this.nickname,
    required this.appearance,
    required this.portrayed,
    required this.category,
    required this.betterCallSaulAppearance,
  });

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      charId: map['char_id'],
      name: map['name'],
      birthday: map['birthday'],
      occupation: List<String>.from(map['occupation']),
      img: map['img'],
      status: map['status'],
      nickname: map['nickname'],
      appearance: List<int>.from(map['appearance']),
      portrayed: map['portrayed'],
      category: map['category'],
      betterCallSaulAppearance:
          List<int>.from(map['better_call_saul_appearance']),
    );
  }

  @override
  String toString() {
    return 'Character(char_id: $charId, name: $name, birthday: $birthday, occupation: $occupation, img: $img, status: $status, nickname: $nickname, appearance: $appearance, portrayed: $portrayed, category: $category, better_call_saul_appearance: $betterCallSaulAppearance)';
  }
}
