import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filert_screen.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:meal_app/provider/meals_provider.dart';
import 'package:meal_app/provider/favourites_provider.dart';
import 'package:meal_app/provider/filters_providers.dart';

const kIntializeFilter = {
  Filter.gluentFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetrain: false,
};

class Tabscreen extends ConsumerStatefulWidget {
  const Tabscreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<Tabscreen> {
  int _selectPageIndex = 0;

  void showInfoMessage(String message) {}

  void _setScreen(identifier) async {
    Navigator.of(context).pop();

    if (identifier == "filters") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => const FilterScreen()),
      );
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final availabelMeals = ref.watch(filterMealProvider);
       

    Widget activePage = CategoriesScreeen(availabelMeals: availabelMeals);
    var activePageTitle = "Categories";
    final favouriteMeals = ref.watch(favouriteMealsProvider);
    if (_selectPageIndex == 1) {
      activePage = MealsScreen(meals: favouriteMeals);
      activePageTitle = "Your Favourites";
    }

    return Scaffold(
      drawer: MainDrawer(onSelectScreen: _setScreen),
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }
}
