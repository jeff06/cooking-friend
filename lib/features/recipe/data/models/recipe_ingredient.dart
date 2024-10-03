import 'package:isar/isar.dart';

part 'recipe_ingredient.g.dart';

@collection
class RecipeIngredient {
  Id id = Isar.autoIncrement;
  String? ingredient;
  String? measuringUnit;
  float? quantity;
  int? order;
}
