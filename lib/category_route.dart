import 'dart:convert';

import 'package:converter_app/backdrop.dart';
import 'package:converter_app/category.dart';
import 'package:converter_app/category_tile.dart';
import 'package:converter_app/unit.dart';
import 'package:converter_app/unit_converter.dart';
import 'package:flutter/material.dart';

class CategoryRoute extends StatefulWidget {

  final String title;

  CategoryRoute({this.title, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CategoryRouteState();
  }

}

class _CategoryRouteState extends State<CategoryRoute>{
  Category _defaultCategory;
  Category _currentCategory;
  final _categories = <Category>[];


  static const _categoriesNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency'
  ];

  static const _categoryColors = <ColorSwatch>[
    ColorSwatch(0xFF6AB7A8, {
      'highlight': Color(0xFF6AB7A8),
      'splash': Color(0xFF0ABC9B),
    }),
    ColorSwatch(0xFFFFD28E, {
      'highlight': Color(0xFFFFD28E),
      'splash': Color(0xFFFFA41C),
    }),
    ColorSwatch(0xFFFFB7DE, {
      'highlight': Color(0xFFFFB7DE),
      'splash': Color(0xFFF94CBF),
    }),
    ColorSwatch(0xFF8899A8, {
      'highlight': Color(0xFF8899A8),
      'splash': Color(0xFFA9CAE8),
    }),
    ColorSwatch(0xFFEAD37E, {
      'highlight': Color(0xFFEAD37E),
      'splash': Color(0xFFFFE070),
    }),
    ColorSwatch(0xFF81A56F, {
      'highlight': Color(0xFF81A56F),
      'splash': Color(0xFF7CC159),
    }),
    ColorSwatch(0xFFD7C0E2, {
      'highlight': Color(0xFFD7C0E2),
      'splash': Color(0xFFCA90E5),
    }),
    ColorSwatch(0xFFCE9A9A, {
      'highlight': Color(0xFFCE9A9A),
      'splash': Color(0xFFF94D56),
      'error': Color(0xFF912D2D),
    })

  ];

  static const _icons = <String>[
    'assets/icons/length.png',
    'assets/icons/area.png',
    'assets/icons/volume.png',
    'assets/icons/mass.png',
    'assets/icons/time.png',
    'assets/icons/digital_storage.png',
    'assets/icons/power.png',
    'assets/icons/currency.png',
  ];


  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    // We have static unit conversions located in our
    // assets/data/regular_units.json
    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
    }
  }



  Future<void> _retrieveLocalCategories() async {
    final json = DefaultAssetBundle.of(context).loadString('assets/regular_units.json');
    final data = JsonDecoder().convert(await json);
    if (data is! Map){
      throw ('Data retrieved from API is not a Map');
    }
    var categoryIndex = 0;
    data.keys.forEach((key) {
      final List<Unit> units= data[key].map<Unit>((dynamic data) => Unit.fromJson(data)).toList();

      var category = Category(
        name: key,
        units: units,
        color: _categoryColors[categoryIndex],
        iconLocation: _icons[categoryIndex]
      );

      setState(() {
        if (categoryIndex == 0){
          _defaultCategory = category;
        }
        _categories.add(category);
      });
      categoryIndex += 1;
    });
  }


  /* List<Unit> _retrieveUnitList(String categoryName) {
    return List.generate(10, (int i) {
      i += 1;
      return Unit(
        name: '$categoryName Unit $i',
        conversion: i.toDouble(),
      );
    });
  } */

/*  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _categoriesNames.length; i++ ){
      var category = Category(name: _categoriesNames[i], color: _categoryColors[i], iconLocation: Icons.cake,units: _retrieveUnitList(_categoriesNames[i]),
      );

      if (i == 0){
        _defaultCategory = category;
      }

      _categories.add(category);



    }
  }*/

  void _onCategoryTap(Category category){
    setState(() {
      _currentCategory = category;
    });
  }



  @override
  Widget build(BuildContext context) {
    if (_categories.isEmpty){
      return Center(
        child: Container(
          height:  180.0,
          width: 180.0,
          child: CircularProgressIndicator(),
        ),
      );
    }
    assert(debugCheckHasMediaQuery(context));
    final listView = Padding(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 48.0
      ),
      child: _buildCategoryWidget(MediaQuery.of(context).orientation),
    );


    // TODO: implement build
    return
     Backdrop(
       currentCategory:
       _currentCategory == null ? _defaultCategory : _currentCategory,
       frontPanel: _currentCategory == null
           ? ConverterRoute(category: _defaultCategory)
           : ConverterRoute(category: _currentCategory),
       backPanel: listView,
       frontTitle: Text('Unit Converter'),
       backTitle: Text('Select a Category'),
     );
  }


  Widget _buildCategoryWidget(Orientation deviceOrientation){
    if (deviceOrientation == Orientation.portrait) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return CategoryTile(
            category: _categories[index],
            onTap: _onCategoryTap,
          );
        },
        itemCount: _categories.length,);
    }else {
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3.0,
        children: _categories.map((Category c) {
          return CategoryTile(
            category: c,
            onTap: _onCategoryTap,
          );
        }).toList(),
      );
    }
  }
}


