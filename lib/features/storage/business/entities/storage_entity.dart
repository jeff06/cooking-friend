import 'package:cooking_friend/features/storage/data/models/storage_model.dart';

class StorageEntity {
  int? idStorage;
  String? name;
  String? date;
  String? code;
  int? quantity;
  String? location;

  StorageEntity(
      this.name, this.date, this.code, this.quantity, this.location, this.idStorage);

  StorageModel toModel() {
    return StorageModel(name, date, code, quantity, location, idStorage);
  }
}
