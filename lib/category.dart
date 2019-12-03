import 'package:converter_app/unit_converter.dart';
import 'package:converter_app/unit.dart';
import 'package:flutter/material.dart';


class Category{

  final String name;
  final ColorSwatch color;
   final String iconLocation;
   final List<Unit> units;

  Category({
      @required this.name,
      @required this.color,
      @required this.iconLocation,
    @required this.units,
  }):
        assert(name != null),
   assert(color != null),
   assert(iconLocation != null),
        assert(units != null);



}