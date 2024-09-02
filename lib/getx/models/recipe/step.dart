import 'package:isar/isar.dart';

part 'step.g.dart';

@collection
class Step {
  Id id = Isar.autoIncrement;
  String? step;
}
