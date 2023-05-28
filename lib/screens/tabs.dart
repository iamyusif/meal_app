import 'package:flutter/material.dart';
import 'package:meels_app/screens/meals.dart';

import '../models/meal.dart';
import 'categories.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  final List<Meal> _favoriteMeals = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _toogleMealFavorite(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    setState(() {
      if (isExisting) {
        setState(() {
          _favoriteMeals.remove(meal);
        });
        _showInfoMessage("Removed from favorites");
      } else {
        setState(() {
          _favoriteMeals.add(meal);
          _showInfoMessage("Added to favorites");
        });
      }
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage =  CategoriesScreen(
      onToggleFavorite: _toogleMealFavorite,
    );
    var activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(meals: _favoriteMeals, onToggleFavorite: _toogleMealFavorite);
      activePageTitle = "Favorites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
