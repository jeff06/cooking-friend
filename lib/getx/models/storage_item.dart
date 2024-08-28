import 'package:isar/isar.dart';

part 'storage_item.g.dart';

@collection
class StorageItem {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  String? name;
  DateTime? date;
  String? code;
}