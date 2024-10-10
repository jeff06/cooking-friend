class ImportedRecipeEntity {
  String? version;
  String? id;
  String? name;
  String? sourceUrl;
  int? servings;
  int? cookTime;
  int? prepTime;
  int? totalTime;
  List<String>? categories;
  List<String>? imageUrls;
  List<String>? keywords;
  List<Ingredients>? ingredients;
  List<Instructions>? instructions;
  String? source;

  ImportedRecipeEntity(
      {this.version,
      this.id,
      this.name,
      this.sourceUrl,
      this.servings,
      this.cookTime,
      this.prepTime,
      this.totalTime,
      this.categories,
      this.imageUrls,
      this.keywords,
      this.ingredients,
      this.instructions,
      this.source});

  ImportedRecipeEntity.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    id = json['id'];
    name = json['name'];
    sourceUrl = json['sourceUrl'];
    servings = json['servings'];
    cookTime = json['cookTime'];
    prepTime = json['prepTime'];
    totalTime = json['totalTime'];
    categories = json['categories'].cast<String>();
    imageUrls = json['imageUrls'].cast<String>();
    keywords = json['keywords'].cast<String>();
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(Ingredients.fromJson(v));
      });
    }
    if (json['instructions'] != null) {
      instructions = <Instructions>[];
      json['instructions'].forEach((v) {
        instructions!.add(Instructions.fromJson(v));
      });
    }
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = version;
    data['id'] = id;
    data['name'] = name;
    data['sourceUrl'] = sourceUrl;
    data['servings'] = servings;
    data['cookTime'] = cookTime;
    data['prepTime'] = prepTime;
    data['totalTime'] = totalTime;
    data['categories'] = categories;
    data['imageUrls'] = imageUrls;
    data['keywords'] = keywords;
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
    }
    if (instructions != null) {
      data['instructions'] = instructions!.map((v) => v.toJson()).toList();
    }
    data['source'] = source;
    return data;
  }
}

class Ingredients {
  String? name;
  List<Items>? items;
  List<Quantities>? quantities;
  List<Units>? units;
  //List<dynamic>? sizes;
  String? type;

  Ingredients(
      {this.name,
      this.items,
      this.quantities,
      this.units,
      //this.sizes,
      this.type});

  Ingredients.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    if (json['quantities'] != null) {
      quantities = <Quantities>[];
      json['quantities'].forEach((v) {
        quantities!.add(Quantities.fromJson(v));
      });
    }
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units!.add(Units.fromJson(v));
      });
    }
    /*if (json['sizes'] != null) {
      sizes = <dynamic>[];
      json['sizes'].forEach((v) {
        sizes!.add(dynamic.fromJson(v));
      });
    }*/
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (quantities != null) {
      data['quantities'] = quantities!.map((v) => v.toJson()).toList();
    }
    if (units != null) {
      data['units'] = units!.map((v) => v.toJson()).toList();
    }
    /*if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }*/
    data['type'] = type;
    return data;
  }
}

class Items {
  double? density;
  String? state;

  Items({this.density, this.state});

  Items.fromJson(Map<String, dynamic> json) {
    density = json['density'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['density'] = density;
    data['state'] = state;
    return data;
  }
}

class Quantities {
  int? start;
  int? end;
  double? value;
  List<PluralityDependents>? pluralityDependents;
  int? unit;

  Quantities(
      {this.start, this.end, this.value, this.pluralityDependents, this.unit});

  Quantities.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
    value = json['value'];
    if (json['plurality_dependents'] != null) {
      pluralityDependents = <PluralityDependents>[];
      json['plurality_dependents'].forEach((v) {
        pluralityDependents!.add(PluralityDependents.fromJson(v));
      });
    }
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start'] = start;
    data['end'] = end;
    data['value'] = value;
    if (pluralityDependents != null) {
      data['plurality_dependents'] =
          pluralityDependents!.map((v) => v.toJson()).toList();
    }
    data['unit'] = unit;
    return data;
  }
}

class PluralityDependents {
  int? start;
  int? end;
  String? plural;
  String? singular;

  PluralityDependents({this.start, this.end, this.plural, this.singular});

  PluralityDependents.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
    plural = json['plural'];
    singular = json['singular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start'] = start;
    data['end'] = end;
    data['plural'] = plural;
    data['singular'] = singular;
    return data;
  }
}

class Units {
  int? start;
  int? end;
  String? id;
  String? displayType;
  int? item;

  Units({this.start, this.end, this.id, this.displayType, this.item});

  Units.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
    id = json['id'];
    displayType = json['display_type'];
    item = json['item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start'] = start;
    data['end'] = end;
    data['id'] = id;
    data['display_type'] = displayType;
    data['item'] = item;
    return data;
  }
}

class Instructions {
  List<Steps>? steps;
  String? name;
  String? type;

  Instructions({this.steps, this.name, this.type});

  Instructions.fromJson(Map<String, dynamic> json) {
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(Steps.fromJson(v));
      });
    }
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (steps != null) {
      data['steps'] = steps!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}

class Steps {
  String? text;
  String? type;

  Steps({this.text, this.type});

  Steps.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['type'] = type;
    return data;
  }
}
