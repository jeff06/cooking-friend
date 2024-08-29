import 'package:isar/isar.dart';

part 'storage_item.g.dart';

@collection
class StorageItem {
  Id id = Isar.autoIncrement;
  String? name;
  DateTime? date;
  String? code;
}