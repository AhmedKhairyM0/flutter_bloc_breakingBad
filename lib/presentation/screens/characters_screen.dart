import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../core/color_palette.dart';
import '../../core/size_config.dart';
import '../../data/models/character_model.dart';
import '../../logic/character/character_cubit.dart';
import '../../logic/character/character_state.dart';
import '../widgets/character_item.dart';
import '../widgets/custom_textform.dart';

class CharactersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // to know device sizes for responsive
    CharacterCubit.get(context).getAllCharacters();
    return BlocBuilder<CharacterCubit, CharacterStates>(
      builder: (context, state) {
        var cubit = CharacterCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            titleSpacing: 40.0,
            title: buildTitleAppBar(cubit),
            actions: buildActionListAppBar(context, cubit),
          ),
          body: OfflineBuilder(
            connectivityBuilder: (context, connectivityResult, child) {
              bool isConnected = connectivityResult != ConnectivityResult.none;
              if (isConnected) {
                print('i am here :: isconnected true');
                // cubit.getAllCharacters();
                return buildBodyWidget(cubit, state);
              } else {
                print('i am here :: isconnected false');

                return buildNoInternetWidget();
              }
            },
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  buildNoInternetWidget() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Check your internet connection',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            child: Image.asset('assets/images/offline.jpeg', fit: BoxFit.cover),
          )
        ],
      ),
    );
  }

  //appBar

  buildTitleAppBar(CharacterCubit cubit) => Builder(
        builder: (_) {
          if (cubit.isSearching)
            return CustomTextForm(
              controller: cubit.searchController,
              hint: 'Search Character ...',
              onChanged: (value) => cubit.searchAboutCharacter(value),
            );
          return Text(
            'Characters',
            style: TextStyle(color: ColorPalette.kPrimaryBackgroundColor),
          );
        },
      );

  buildActionListAppBar(context, CharacterCubit cubit) => [
        Builder(
          builder: (_) {
            if (cubit.isSearching)
              return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    if (cubit.isEmptyTextField) Navigator.pop(context);
                    cubit.clearSearch();
                  });
            return IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  cubit.startSearch(context);
                });
          },
        )
      ];

  // body
  Widget buildBodyWidget(CharacterCubit cubit, state) {
    if (state is CharacterLoading) return buildLoadingWidget();
    if (cubit.isSearching) {
      if (cubit.searchedCharacters.isEmpty) {
        if (cubit.isEmptyTextField) return buildLoadedWidget(cubit.characters);
        return buildNotFoundWidget();
      }
      return buildLoadedWidget(cubit.searchedCharacters);
    }
    return buildLoadedWidget(cubit.characters);
  }

  Widget buildNotFoundWidget() {
    return Center(
      child: Text(
        'Not Found',
        style: TextStyle(
            color: ColorPalette.kPrimaryBackgroundColor, fontSize: 30),
      ),
    );
  }

  Widget buildLoadedWidget(List<Character> characters) {
    return Container(
      color: ColorPalette.kPrimaryBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 7),
      child: GridView.builder(
        itemCount: characters.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 2 / 3,
        ),
        itemBuilder: (_, index) => CharacterItem(character: characters[index]),
      ),
    );
  }

  Widget buildLoadingWidget() {
    return Center(child: CircularProgressIndicator());
  }
}
