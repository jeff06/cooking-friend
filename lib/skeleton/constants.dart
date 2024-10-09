import 'package:flutter/material.dart';

enum StorageManagementAction {
  add("add"),
  view("view"),
  edit("edit"),
  none("none"),
  delete("delete");

  // can add more properties or getters/methods if needed
  final String paramName;

  // can use named parameters if you want
  const StorageManagementAction(this.paramName);
}

enum RecipeManagementAction {
  add("add"),
  view("view"),
  edit("edit"),
  none("none"),
  delete("delete");

  // can add more properties or getters/methods if needed
  final String paramName;

  // can use named parameters if you want
  const RecipeManagementAction(this.paramName);
}

enum RecipeOrderBy {
  id("id"),
  name("name"),
  favorite("favorite");

  // can add more properties or getters/methods if needed
  final String paramName;

  // can use named parameters if you want
  const RecipeOrderBy(this.paramName);
}

enum StorageOrderBy {
  id("id"),
  name("name");

  // can add more properties or getters/methods if needed
  final String paramName;

  // can use named parameters if you want
  const StorageOrderBy(this.paramName);
}

enum OrderByDirection {
  ascending("ascending"),
  descending("descending");

  // can add more properties or getters/methods if needed
  final String paramName;

  // can use named parameters if you want
  const OrderByDirection(this.paramName);
}

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

enum SqfliteRecipeStepTable {
  tableName("recipe_step"),
  id("idStep"),
  idRecipe("idRecipe"),
  step("step"),
  order("order");

  final String paramName;

  const SqfliteRecipeStepTable(this.paramName);
}

enum SqfliteRecipeIngredientTable {
  tableName("recipe_ingredient"),
  id("idIngredient"),
  idRecipe("idRecipe"),
  ingredient("ingredient"),
  measuringUnit("measuringUnit"),
  quantity("quantity"),
  order("order");

  final String paramName;

  const SqfliteRecipeIngredientTable(this.paramName);
}

enum SqfliteRecipeTable {
  tableName("recipe"),
  id("idRecipe"),
  title("title"),
  idFavorite("isFavorite");

  final String paramName;

  const SqfliteRecipeTable(this.paramName);
}

enum SqfliteStorageTable {
  tableName("storage"),
  id("idStorage"),
  name("name"),
  date("date"),
  code("code"),
  location("location"),
  quantity("quantity");

  // can add more properties or getters/methods if needed
  final String paramName;

  // can use named parameters if you want
  const SqfliteStorageTable(this.paramName);
}
