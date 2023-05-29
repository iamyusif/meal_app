import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meels_app/providers/meals_provider.dart';

enum FilterOptions {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FiltersNotifier extends StateNotifier<Map<FilterOptions, bool>> {
  FiltersNotifier()
      : super({
          FilterOptions.glutenFree: false,
          FilterOptions.lactoseFree: false,
          FilterOptions.vegan: false,
          FilterOptions.vegetarian: false,
        });

  void setFilters(Map<FilterOptions, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(FilterOptions filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider =
    StateNotifierProvider<FiltersNotifier, Map<FilterOptions, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);
  return meals.where((meal) {
    if (activeFilters[FilterOptions.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[FilterOptions.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[FilterOptions.vegan]! && !meal.isVegan) {
      return false;
    }
    if (activeFilters[FilterOptions.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
