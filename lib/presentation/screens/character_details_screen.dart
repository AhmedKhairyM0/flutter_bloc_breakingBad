import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/color_palette.dart';
import '../../core/size_config.dart';
import '../../data/models/character_model.dart';
import '../../data/models/quote_model.dart';
import '../../logic/character/character_cubit.dart';
import '../../logic/character/character_state.dart';


class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    // CharacterCubit.get(context).getCharacterQuotes(character.name);
    return Scaffold(
      backgroundColor: ColorPalette.kPrimaryBackgroundColor,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                    color: ColorPalette.kPrimaryBackgroundColor,
                    height: SizeConfig.screenHeight - 100.0,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        characterInfo(
                            title: 'Job',
                            value: character.occupation.join(' / ')),
                        buildDivider(width: 4),
                        characterInfo(
                            title: 'Appeared in', value: character.category),
                        buildDivider(width: 12),
                        characterInfo(
                            title: 'Seasons',
                            value: character.appearance.join(' / ')),
                        buildDivider(width: 8),
                        Builder(builder: (_) {
                          if (character.betterCallSaulAppearance.isNotEmpty) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  characterInfo(
                                      title: 'Better Call Saul seasons',
                                      value: character.betterCallSaulAppearance
                                          .join(' / ')),
                                  buildDivider(width: 23)
                                ]);
                          }
                          return Container();
                        }),
                        characterInfo(title: 'status', value: character.status),
                        buildDivider(width: 6),
                        characterInfo(
                            title: 'Actor/Actress', value: character.portrayed),
                        buildDivider(width: 13),
                        BlocBuilder<CharacterCubit, CharacterStates>(
                          builder: (context, state) {
                            var cubit = CharacterCubit.get(context);
                            cubit.getCharacterQuotes(character.name);
                            return displayDataIfIsAvailable(state);
                          },
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  displayDataIfIsAvailable(CharacterStates state) {
    if (state is CharacterQouteLoaded) {
      print('from displayDataIfIsAvailable() :: ${state.quotes}');
      return displayQouteOrEmptySpace(state.quotes);
    } else {
      return showLoadingIndicator();
    }
  }

  Widget showLoadingIndicator() => Center(child: CircularProgressIndicator());

  Widget displayQouteOrEmptySpace(List<Quote> quotes) {
    if (quotes.isNotEmpty) {
      return buildCharacterQoute(quotes);
    } else {
      return Container();
    }
  }

  Widget buildCharacterQoute(List<Quote> quotes) {
    int index = Random().nextInt(quotes.length - 1);
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.all(20),
      child: AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          FlickerAnimatedText(
            quotes[index].quote,
            textAlign: TextAlign.right,
            textStyle: TextStyle(
                color: ColorPalette.kPrimaryColor,
                fontSize: 18,
                shadows: [
                  Shadow(color: ColorPalette.kOnPrimaryColor, blurRadius: 10)
                ]),
            speed: Duration(milliseconds: 1200),
          )
        ],
      ),
    );
  }

  Widget characterInfo({required String title, required String value}) {
    return RichText(
      text: TextSpan(
          text: title + ':\t\t',
          style: TextStyle(
              fontSize: 18.0,
              color: ColorPalette.kOnPrimaryColor,
              fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 16,
                color: ColorPalette.kOnPrimaryColor,
                fontWeight: FontWeight.normal,
              ),
            )
          ]),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  buildDivider({double? width}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: ColorPalette.kPrimaryColor,
      height: 2,
      width: width! * 9,
    );
  }

  buildSliverAppBar() {
    return SliverAppBar(
      leading: BackButton(color: ColorPalette.kOnPrimaryColor),
      expandedHeight: SizeConfig.screenHeight * 3 / 5,
      pinned: true,
      // stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickname,
          style: TextStyle(
            color: ColorPalette.kOnPrimaryColor,
          ),
        ),
        // centerTitle: true,
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.img,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
