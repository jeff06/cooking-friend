import 'package:isar/isar.dart';

part 'recipe_step.g.dart';

@collection
class RecipeStep {
  Id id = Isar.autoIncrement;
  String? step;
}
