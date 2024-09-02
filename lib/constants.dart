import 'package:flutter/material.dart';

enum StorageManagementAction { add, view, edit, none, delete }
const List<DropdownMenuItem> measurementUnits = [
  DropdownMenuItem(
    value: "cup",
    child: Text("CUP"),
  ),
  DropdownMenuItem(
    value: "g",
    child: Text("G"),
  ),
  DropdownMenuItem(
    value: "l",
    child: Text("L"),
  ),
  DropdownMenuItem(
    value: "lbs",
    child: Text("LBS"),
  ),
  DropdownMenuItem(
    value: "ml",
    child: Text("ML"),
  ),
  DropdownMenuItem(
    value: "tbs",
    child: Text("TBS"),
  ),
  DropdownMenuItem(
    value: "tsp",
    child: Text("tsp"),
  ),
  DropdownMenuItem(
    value: "unit",
    child: Text("Unit"),
  ),
];