import 'package:converter_app/category.dart';
import 'package:converter_app/unit.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {

  final String title;

  MyHomePage({this.title, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState();
  }

}

class _MyHomePageState extends State<MyHomePage>{
  MyHomePage page = new MyHomePage();
  final categories = <Category>[];


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

  static const _categoryColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red

  ];

  List<Unit> _retrieveUnitList(String categoryName) {
    return List.generate(10, (int i) {
      i += 1;
      return Unit(
        name: '$categoryName Unit $i',
        conversion: i.toDouble(),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < _categoriesNames.length; i++ ){
      categories.add(Category(name: _categoriesNames[i], color: _categoryColors[i], iconLocation: Icons.cake,units: _retrieveUnitList(_categoriesNames[i]),
      ));

    }
  }


  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return
      Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Unit Converter',
            ),
          ),
        ),
       body: Container(
         color: Colors.pink.shade50,
      child: _categories(categories)
    ));
  }


}

Widget _categories(List<Category> categories){
return ListView.builder(
  itemBuilder: (BuildContext context, int index) => categories[index],
  itemCount: categories.length,);


}
