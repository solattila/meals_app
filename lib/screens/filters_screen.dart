import 'package:flutter/material.dart';
import 'package:mealsapp/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState(){
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListTile(bool isFree, String title, String subTitle,
      Function updateValue) {
    return SwitchListTile.adaptive(
      title: Text(title),
      value: isFree,
      subtitle: Text(subTitle),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Szürők'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.save), onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian
              };
              widget.saveFilters(selectedFilters);
            })
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Receptek meghatározása.',
                style: Theme
                    .of(context)
                    .textTheme
                    .title,
              ),
            ),
            Expanded(
                child: ListView(
                  children: <Widget>[
                    _buildSwitchListTile(_glutenFree, 'Gluténmentes',
                        'Csak gluténmentes ételek mutatása.', (newValue) {
                          setState(() {
                            _glutenFree = newValue;
                          });
                        }),
                    _buildSwitchListTile(_lactoseFree, 'Laktózmentes',
                        'Csak laktózmentes ételek mutatása', (newValue) {
                          setState(() {
                            _lactoseFree = newValue;
                          });
                        }),
                    _buildSwitchListTile(
                        _vegan, 'Vegán', 'Csak vegán ételek mutatása.', (
                        newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    }),
                    _buildSwitchListTile(_vegetarian, 'Vegetáriánus',
                        'Csak vegetáriánus ételek mutatása', (newValue) {
                          setState(() {
                            _vegetarian = newValue;
                          });
                        }),
                  ],
                ))
          ],
        ));
  }
}
