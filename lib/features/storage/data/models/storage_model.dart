import 'package:cooking_friend/features/storage/business/entities/storage_entity.dart';
import 'package:isar/isar.dart';

part 'storage_model.g.dart';

@collection
class StorageModel extends StorageEntity {
  Id? id = Isar.autoIncrement;

  StorageModel(
      super.name, super.date, super.code, super.quantity, super.location, super.id);
}
