import 'package:breaking_bad_bad/core/color_palette.dart';
import 'package:breaking_bad_bad/data/models/character_model.dart';
import 'package:breaking_bad_bad/route.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({Key? key, required this.character}) : super(key: key);

  final Character character;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteGenerator.characterDetails,
            arguments: character);
      },
      child: Container(
        // margin: EdgeInsets.only(),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: ColorPalette.kOnPrimaryColor,
        ),
        child: Hero(
          tag: character.charId,
          child: Container(
            margin: EdgeInsets.all(6),
            child: GridTile(
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image: character.img.isNotEmpty
                    ? character.img
                    : 'assets/images/placeholder.png',
                fit: BoxFit.cover,
              ),
              footer: Container(
                color: ColorPalette.kPrimaryBackgroundColor.withOpacity(0.6),
                height: 45.0,
                alignment: Alignment.center,
                child: Text(
                  character.name,
                  style: TextStyle(
                    color: ColorPalette.kOnPrimaryColor,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// Card(
//       shape: BeveledRectangleBorder(
//         side: BorderSide(color: ColorPalette.kOnPrimaryColor, width: 2),
//         borderRadius: BorderRadius.all(Radius.circular(5)),
//       ),
//       child: Stack(
//         children: [
//           Positioned(
//             right: 0,
//             left: 0,
//             child: Image(
//               image: NetworkImage(character.img),
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             left: 0,
//             child: Container(
//               padding: EdgeInsets.only(top: 5.0),
//               width: double.infinity,
//               height: 40.0,
//               color: ColorPalette.kPrimaryBackgroundColor.withOpacity(0.8),
//               child: Text(
//                 character.name,
//                 style: TextStyle(color: ColorPalette.kOnPrimaryColor),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );