
import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filert_screen.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widgets/main_drawer.dart';

const kIntializeFilter = {
  Filter.gluentFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetrain: false,
};

class Tabscreen extends StatefulWidget {
  const Tabscreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<Tabscreen> {
  int _selectPageIndex = 0;
  final List<Meal> _favouriteMeals = [];
  Map<Filter, bool> _selectedFilters = kIntializeFilter;

  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _setScreen(identifier) async {
    Navigator.of(context).pop();

    if (identifier == "filters") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => FilterScreen( cureentFilters: _selectedFilters,)),
      );

      setState(() {
        _selectedFilters = result ?? kIntializeFilter;
      });
    }
  }

  void toggleMoveFavouriteList(Meal meal) {
    final isExiting = _favouriteMeals.contains(meal);

    if (isExiting) {
      setState(() {
        _favouriteMeals.remove(meal);
        showInfoMessage("Meal is no more favourite");
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
        showInfoMessage("Meal is added as favourite");
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availabelMeals =
        dummyMeals.where((meal) {
          if (_selectedFilters[Filter.gluentFree]! && !meal.isGlutenFree) {
            return false;
          }

          if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
            return false;
          }

          if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }

          if (_selectedFilters[Filter.vegetrain]! && !meal.isVegetarian) {
            return false;
          }
          return true;
        }).toList();

    Widget activePage = CategoriesScreeen(
      onToggleFavourite: toggleMoveFavouriteList,
      availabelMeals: availabelMeals,
    );
    var activePageTitle = "Categories";

    if (_selectPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favouriteMeals,
        onToggleFavourite: toggleMoveFavouriteList,
      );
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
