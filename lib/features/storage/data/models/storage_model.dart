import 'package:cooking_friend/features/storage/business/entities/storage_entity.dart';

class StorageModel extends StorageEntity {
  StorageModel(super.name, super.date, super.code, super.quantity,
      super.location, super.idStorage);

  factory StorageModel.fromJson(Map<String, Object?> json) {
    return StorageModel(
        json['name'].toString(),
        json['date'].toString(),
        json['code'].toString(),
        int.parse(json['quantity'].toString()),
        json['location'].toString(),
        int.parse(json['idStorage'].toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['date'] = date;
    data['code'] = code;
    data['quantity'] = quantity;
    data['location'] = location;
    data['idStorage'] = idStorage;

    return data;
  }
}
