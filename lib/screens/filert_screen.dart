import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:meal_app/screens/tabs.dart';

enum Filter{
    gluentFree,
    lactoseFree,
    vegan,
    vegetrain
  }

class FilterScreen extends StatefulWidget {

const FilterScreen({super.key , required this.cureentFilters});

final Map<Filter,bool> cureentFilters; 

  @override
  State<StatefulWidget> createState() {
    return _FilterScreen();
  }
}

class _FilterScreen extends State<FilterScreen> {
  var _gluentFilterSet = false;
  var _lactoseFilterSet = false;
  var _vegetarinFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _gluentFilterSet = widget.cureentFilters[Filter.gluentFree]!;
     _lactoseFilterSet = widget.cureentFilters[Filter.lactoseFree]!;
    _veganFilterSet = widget.cureentFilters[Filter.vegan]!;
  _veganFilterSet = widget.cureentFilters[Filter.vegetrain]!;

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Filters")),
      drawer: MainDrawer(
        onSelectScreen: (identifier) {
          Navigator.pop(context);
          if (identifier == "meals") {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (ctx) => const Tabscreen()));
          }
        },
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.gluentFree: _gluentFilterSet,
            Filter.lactoseFree: _lactoseFilterSet,
            Filter.vegetrain: _vegetarinFilterSet,
            Filter.vegan: _veganFilterSet,
          });
        },
        child: Column(
          children: [
            SwitchListTile( 
              value: _gluentFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _gluentFilterSet = isChecked;
                });
              },
              title: Text(
                "Gluent-Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                "Only include glunt-free meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(right: 22, left: 34),
            ),
            SwitchListTile(
              value: _lactoseFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFilterSet = isChecked;
                });
              },
              title: Text(
                "Lactose-Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                "Only include lactose-free meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(right: 22, left: 34),
            ),
            SwitchListTile(
              value: _vegetarinFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarinFilterSet = isChecked;
                });
              },
              title: Text(
                "Vegetarian meal",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                "Only include vegetrain meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(right: 22, left: 34),
            ),
            SwitchListTile(
              value: _veganFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
              title: Text(
                "Vegans meal",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                "Only include vegan meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(right: 22, left: 34),
            ),
          ],
        ),
      ),
    );
  }
}
