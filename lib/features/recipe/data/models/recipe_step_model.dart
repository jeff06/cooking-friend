import 'package:isar/isar.dart';

part 'recipe_step_model.g.dart';

@collection
class RecipeStepModel {
  Id id = Isar.autoIncrement;
  String? step;
  int? order;
}
