class RecipeIngredientEntity{
  final int id;
  final String? ingredient;
  final String? measuringUnit;
  final double? quantity;
  final int? order;

  RecipeIngredientEntity(this.id, this.ingredient, this.measuringUnit, this.quantity, this.order);
}