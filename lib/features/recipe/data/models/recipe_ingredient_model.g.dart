// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_ingredient_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecipeIngredientModelCollection on Isar {
  IsarCollection<RecipeIngredientModel> get recipeIngredientModels =>
      this.collection();
}

const RecipeIngredientModelSchema = CollectionSchema(
  name: r'RecipeIngredientModel',
  id: 2831672226557135585,
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
    r'order': PropertySchema(
      id: 2,
      name: r'order',
      type: IsarType.long,
    ),
    r'quantity': PropertySchema(
      id: 3,
      name: r'quantity',
      type: IsarType.float,
    )
  },
  estimateSize: _recipeIngredientModelEstimateSize,
  serialize: _recipeIngredientModelSerialize,
  deserialize: _recipeIngredientModelDeserialize,
  deserializeProp: _recipeIngredientModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recipeIngredientModelGetId,
  getLinks: _recipeIngredientModelGetLinks,
  attach: _recipeIngredientModelAttach,
  version: '3.1.0+1',
);

int _recipeIngredientModelEstimateSize(
  RecipeIngredientModel object,
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

void _recipeIngredientModelSerialize(
  RecipeIngredientModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ingredient);
  writer.writeString(offsets[1], object.measuringUnit);
  writer.writeLong(offsets[2], object.order);
  writer.writeFloat(offsets[3], object.quantity);
}

RecipeIngredientModel _recipeIngredientModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecipeIngredientModel();
  object.id = id;
  object.ingredient = reader.readStringOrNull(offsets[0]);
  object.measuringUnit = reader.readStringOrNull(offsets[1]);
  object.order = reader.readLongOrNull(offsets[2]);
  object.quantity = reader.readFloatOrNull(offsets[3]);
  return object;
}

P _recipeIngredientModelDeserializeProp<P>(
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
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readFloatOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recipeIngredientModelGetId(RecipeIngredientModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recipeIngredientModelGetLinks(
    RecipeIngredientModel object) {
  return [];
}

void _recipeIngredientModelAttach(
    IsarCollection<dynamic> col, Id id, RecipeIngredientModel object) {
  object.id = id;
}

extension RecipeIngredientModelQueryWhereSort
    on QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QWhere> {
  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecipeIngredientModelQueryWhere on QueryBuilder<RecipeIngredientModel,
    RecipeIngredientModel, QWhereClause> {
  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterWhereClause>
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterWhereClause>
      idBetween(
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

extension RecipeIngredientModelQueryFilter on QueryBuilder<
    RecipeIngredientModel, RecipeIngredientModel, QFilterCondition> {
  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> ingredientIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ingredient',
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> ingredientIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ingredient',
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> ingredientEqualTo(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> ingredientGreaterThan(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> ingredientLessThan(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> ingredientBetween(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> ingredientStartsWith(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> ingredientEndsWith(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
          QAfterFilterCondition>
      ingredientContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ingredient',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
          QAfterFilterCondition>
      ingredientMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ingredient',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> ingredientIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ingredient',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> ingredientIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ingredient',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> measuringUnitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'measuringUnit',
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> measuringUnitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'measuringUnit',
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> measuringUnitEqualTo(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> measuringUnitGreaterThan(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> measuringUnitLessThan(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> measuringUnitBetween(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> measuringUnitStartsWith(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> measuringUnitEndsWith(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
          QAfterFilterCondition>
      measuringUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'measuringUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
          QAfterFilterCondition>
      measuringUnitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'measuringUnit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> measuringUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'measuringUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> measuringUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'measuringUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> orderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'order',
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> orderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'order',
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> orderEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> orderGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> orderLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> orderBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'order',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> quantityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> quantityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> quantityEqualTo(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> quantityGreaterThan(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> quantityLessThan(
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

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel,
      QAfterFilterCondition> quantityBetween(
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

extension RecipeIngredientModelQueryObject on QueryBuilder<
    RecipeIngredientModel, RecipeIngredientModel, QFilterCondition> {}

extension RecipeIngredientModelQueryLinks on QueryBuilder<RecipeIngredientModel,
    RecipeIngredientModel, QFilterCondition> {}

extension RecipeIngredientModelQuerySortBy
    on QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QSortBy> {
  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      sortByIngredient() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ingredient', Sort.asc);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      sortByIngredientDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ingredient', Sort.desc);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      sortByMeasuringUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'measuringUnit', Sort.asc);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      sortByMeasuringUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'measuringUnit', Sort.desc);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      sortByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      sortByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }
}

extension RecipeIngredientModelQuerySortThenBy
    on QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QSortThenBy> {
  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      thenByIngredient() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ingredient', Sort.asc);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      thenByIngredientDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ingredient', Sort.desc);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      thenByMeasuringUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'measuringUnit', Sort.asc);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      thenByMeasuringUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'measuringUnit', Sort.desc);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      thenByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      thenByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QAfterSortBy>
      thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }
}

extension RecipeIngredientModelQueryWhereDistinct
    on QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QDistinct> {
  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QDistinct>
      distinctByIngredient({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ingredient', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QDistinct>
      distinctByMeasuringUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'measuringUnit',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QDistinct>
      distinctByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'order');
    });
  }

  QueryBuilder<RecipeIngredientModel, RecipeIngredientModel, QDistinct>
      distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }
}

extension RecipeIngredientModelQueryProperty on QueryBuilder<
    RecipeIngredientModel, RecipeIngredientModel, QQueryProperty> {
  QueryBuilder<RecipeIngredientModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecipeIngredientModel, String?, QQueryOperations>
      ingredientProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ingredient');
    });
  }

  QueryBuilder<RecipeIngredientModel, String?, QQueryOperations>
      measuringUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'measuringUnit');
    });
  }

  QueryBuilder<RecipeIngredientModel, int?, QQueryOperations> orderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'order');
    });
  }

  QueryBuilder<RecipeIngredientModel, double?, QQueryOperations>
      quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }
}
