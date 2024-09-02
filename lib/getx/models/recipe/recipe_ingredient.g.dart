// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_ingredient.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecipeIngredientCollection on Isar {
  IsarCollection<RecipeIngredient> get recipeIngredients => this.collection();
}

const RecipeIngredientSchema = CollectionSchema(
  name: r'RecipeIngredient',
  id: -7135109042295776315,
  properties: {
    r'ingredient': PropertySchema(
      id: 0,
      name: r'ingredient',
      type: IsarType.string,
    ),
    r'measuringUnit': PropertySchema(
      id: 1,
      name: r'measuringUnit',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 2,
      name: r'quantity',
      type: IsarType.float,
    )
  },
  estimateSize: _recipeIngredientEstimateSize,
  serialize: _recipeIngredientSerialize,
  deserialize: _recipeIngredientDeserialize,
  deserializeProp: _recipeIngredientDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recipeIngredientGetId,
  getLinks: _recipeIngredientGetLinks,
  attach: _recipeIngredientAttach,
  version: '3.1.0+1',
);

int _recipeIngredientEstimateSize(
  RecipeIngredient object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.ingredient;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.measuringUnit;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _recipeIngredientSerialize(
  RecipeIngredient object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ingredient);
  writer.writeString(offsets[1], object.measuringUnit);
  writer.writeFloat(offsets[2], object.quantity);
}

RecipeIngredient _recipeIngredientDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecipeIngredient();
  object.id = id;
  object.ingredient = reader.readStringOrNull(offsets[0]);
  object.measuringUnit = reader.readStringOrNull(offsets[1]);
  object.quantity = reader.readFloatOrNull(offsets[2]);
  return object;
}

P _recipeIngredientDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readFloatOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recipeIngredientGetId(RecipeIngredient object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recipeIngredientGetLinks(RecipeIngredient object) {
  return [];
}

void _recipeIngredientAttach(
    IsarCollection<dynamic> col, Id id, RecipeIngredient object) {
  object.id = id;
}

extension RecipeIngredientQueryWhereSort
    on QueryBuilder<RecipeIngredient, RecipeIngredient, QWhere> {
  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecipeIngredientQueryWhere
    on QueryBuilder<RecipeIngredient, RecipeIngredient, QWhereClause> {
  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RecipeIngredientQueryFilter
    on QueryBuilder<RecipeIngredient, RecipeIngredient, QFilterCondition> {
  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      ingredientIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ingredient',
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      ingredientIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ingredient',
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      ingredientEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ingredient',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      ingredientGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ingredient',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      ingredientLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ingredient',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      ingredientBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ingredient',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      ingredientStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ingredient',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      ingredientEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ingredient',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      ingredientContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ingredient',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      ingredientMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ingredient',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      ingredientIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ingredient',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      ingredientIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ingredient',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      measuringUnitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'measuringUnit',
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      measuringUnitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'measuringUnit',
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      measuringUnitEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'measuringUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      measuringUnitGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'measuringUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      measuringUnitLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'measuringUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      measuringUnitBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'measuringUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      measuringUnitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'measuringUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      measuringUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'measuringUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      measuringUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'measuringUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      measuringUnitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'measuringUnit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      measuringUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'measuringUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      measuringUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'measuringUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      quantityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      quantityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      quantityEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      quantityGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      quantityLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterFilterCondition>
      quantityBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension RecipeIngredientQueryObject
    on QueryBuilder<RecipeIngredient, RecipeIngredient, QFilterCondition> {}

extension RecipeIngredientQueryLinks
    on QueryBuilder<RecipeIngredient, RecipeIngredient, QFilterCondition> {}

extension RecipeIngredientQuerySortBy
    on QueryBuilder<RecipeIngredient, RecipeIngredient, QSortBy> {
  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterSortBy>
      sortByIngredient() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ingredient', Sort.asc);
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterSortBy>
      sortByIngredientDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ingredient', Sort.desc);
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterSortBy>
      sortByMeasuringUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'measuringUnit', Sort.asc);
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterSortBy>
      sortByMeasuringUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'measuringUnit', Sort.desc);
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterSortBy>
      sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterSortBy>
      sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }
}

extension RecipeIngredientQuerySortThenBy
    on QueryBuilder<RecipeIngredient, RecipeIngredient, QSortThenBy> {
  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterSortBy>
      thenByIngredient() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ingredient', Sort.asc);
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterSortBy>
      thenByIngredientDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ingredient', Sort.desc);
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterSortBy>
      thenByMeasuringUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'measuringUnit', Sort.asc);
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterSortBy>
      thenByMeasuringUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'measuringUnit', Sort.desc);
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterSortBy>
      thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QAfterSortBy>
      thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }
}

extension RecipeIngredientQueryWhereDistinct
    on QueryBuilder<RecipeIngredient, RecipeIngredient, QDistinct> {
  QueryBuilder<RecipeIngredient, RecipeIngredient, QDistinct>
      distinctByIngredient({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ingredient', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QDistinct>
      distinctByMeasuringUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'measuringUnit',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecipeIngredient, RecipeIngredient, QDistinct>
      distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }
}

extension RecipeIngredientQueryProperty
    on QueryBuilder<RecipeIngredient, RecipeIngredient, QQueryProperty> {
  QueryBuilder<RecipeIngredient, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecipeIngredient, String?, QQueryOperations>
      ingredientProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ingredient');
    });
  }

  QueryBuilder<RecipeIngredient, String?, QQueryOperations>
      measuringUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'measuringUnit');
    });
  }

  QueryBuilder<RecipeIngredient, double?, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }
}
