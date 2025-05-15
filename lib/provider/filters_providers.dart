import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/provider/meals_provider.dart';

enum Filter { gluentFree, lactoseFree, vegan, vegetrain }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
    : super({
        Filter.gluentFree: false,
        Filter.lactoseFree: false,
        Filter.vegan: false,
        Filter.vegetrain: false,
      });

  void setFilters(Map<Filter, bool> choseFilters) {
    state = choseFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);


final filterMealProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider); // Fixed here

  return meals.where((meal) {
    if (activeFilters[Filter.gluentFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetrain]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});