class StorageEntity {
  final int? id;
  final String? name;
  final DateTime? date;
  final String? code;
  final int? quantity;
  final String? location;

  StorageEntity(
      this.name, this.date, this.code, this.quantity, this.location, this.id);
}
