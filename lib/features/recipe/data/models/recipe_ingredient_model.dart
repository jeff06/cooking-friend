import 'package:isar/isar.dart';

part 'recipe_ingredient_model.g.dart';

@collection
class RecipeIngredientModel {
  Id id = Isar.autoIncrement;
  String? ingredient;
  String? measuringUnit;
  float? quantity;
  int? order;
}
