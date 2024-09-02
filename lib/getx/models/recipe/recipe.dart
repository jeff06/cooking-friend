import 'package:isar/isar.dart';

part 'recipe.g.dart';

@collection
class Recipe {
  Id id = Isar.autoIncrement;
  String? name;
  //final steps = IsarLinks<Step>();
}
