class Product {
  int? id;
  String? name;
  String? slug;
  String? permalink;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? type;
  String? status;
  bool? featured;
  String? catalogVisibility;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  bool? onSale;
  bool? purchasable;
  int? totalSales;
  bool? virtual;
  bool? downloadable;
  int? downloadLimit;
  int? downloadExpiry;
  String? externalUrl;
  String? buttonText;
  String? taxStatus;
  String? taxClass;
  bool? manageStock;
  int? stockQuantity;
  String? backorders;
  bool? backordersAllowed;
  bool? backordered;
  bool? soldIndividually;
  String? weight;
  Dimensions? dimensions;
  bool? shippingRequired;
  bool? shippingTaxable;
  String? shippingClass;
  int? shippingClassId;
  bool? reviewsAllowed;
  String? averageRating;
  int? ratingCount;
  int? parentId;
  String? purchaseNote;
  List<Categories>? categories;
  List<Images>? images;
  int? menuOrder;
  String? priceHtml;
  List<int>? relatedIds;
  List<MetaData>? metaData;
  String? stockStatus;
  bool? hasOptions;
  String? postPassword;
  String? wooqrCode;
  Links? lLinks;

  Product({
    this.id,
    this.name,
    this.slug,
    this.permalink,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.type,
    this.status,
    this.featured,
    this.catalogVisibility,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.onSale,
    this.purchasable,
    this.totalSales,
    this.virtual,
    this.downloadable,
    this.downloadLimit,
    this.downloadExpiry,
    this.externalUrl,
    this.buttonText,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.backorders,
    this.backordersAllowed,
    this.backordered,
    this.soldIndividually,
    this.weight,
    this.dimensions,
    this.shippingRequired,
    this.shippingTaxable,
    this.shippingClass,
    this.shippingClassId,
    this.reviewsAllowed,
    this.averageRating,
    this.ratingCount,
    this.parentId,
    this.purchaseNote,
    this.categories,
    this.images,
    this.menuOrder,
    this.priceHtml,
    this.relatedIds,
    this.metaData,
    this.stockStatus,
    this.hasOptions,
    this.postPassword,
    this.wooqrCode,
    this.lLinks,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    permalink = json['permalink'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    type = json['type'];
    status = json['status'];
    featured = json['featured'];
    catalogVisibility = json['catalog_visibility'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    onSale = json['on_sale'];
    purchasable = json['purchasable'];
    totalSales = json['total_sales'];
    virtual = json['virtual'];
    downloadable = json['downloadable'];
    downloadLimit = json['download_limit'];
    downloadExpiry = json['download_expiry'];
    externalUrl = json['external_url'];
    buttonText = json['button_text'];
    taxStatus = json['tax_status'];
    taxClass = json['tax_class'];
    manageStock = json['manage_stock'];
    stockQuantity = json['stock_quantity'];
    backorders = json['backorders'];
    backordersAllowed = json['backorders_allowed'];
    backordered = json['backordered'];
    soldIndividually = json['sold_individually'];
    weight = json['weight'];
    dimensions =
        json['dimensions'] != null ? Dimensions.fromJson(json['dimensions']) : null;
    shippingRequired = json['shipping_required'];
    shippingTaxable = json['shipping_taxable'];
    shippingClass = json['shipping_class'];
    shippingClassId = json['shipping_class_id'];
    reviewsAllowed = json['reviews_allowed'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
    parentId = json['parent_id'];
    purchaseNote = json['purchase_note'];

    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }

    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }

    menuOrder = json['menu_order'];
    priceHtml = json['price_html'];
    relatedIds = json['related_ids'].cast<int>();
    stockStatus = json['stock_status'];
    hasOptions = json['has_options'];
    postPassword = json['post_password'];
    wooqrCode = json['wooqr_code'];
    lLinks = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['permalink'] = permalink;
    data['date_created'] = dateCreated;
    data['date_created_gmt'] = dateCreatedGmt;
    data['date_modified'] = dateModified;
    data['date_modified_gmt'] = dateModifiedGmt;
    data['type'] = type;
    data['status'] = status;
    data['featured'] = featured;
    data['catalog_visibility'] = catalogVisibility;
    data['description'] = description;
    data['short_description'] = shortDescription;
    data['sku'] = sku;
    data['price'] = price;
    data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['on_sale'] = onSale;
    data['purchasable'] = purchasable;
    data['total_sales'] = totalSales;
    data['virtual'] = virtual;
    data['downloadable'] = downloadable;
    data['download_limit'] = downloadLimit;
    data['download_expiry'] = downloadExpiry;
    data['external_url'] = externalUrl;
    data['button_text'] = buttonText;
    data['tax_status'] = taxStatus;
    data['tax_class'] = taxClass;
    data['manage_stock'] = manageStock;
    data['stock_quantity'] = stockQuantity;
    data['backorders'] = backorders;
    data['backorders_allowed'] = backordersAllowed;
    data['backordered'] = backordered;
    data['sold_individually'] = soldIndividually;
    data['weight'] = weight;
    if (dimensions != null) {
      data['dimensions'] = dimensions!.toJson();
    }
    data['shipping_required'] = shippingRequired;
    data['shipping_taxable'] = shippingTaxable;
    data['shipping_class'] = shippingClass;
    data['shipping_class_id'] = shippingClassId;
    data['reviews_allowed'] = reviewsAllowed;
    data['average_rating'] = averageRating;
    data['rating_count'] = ratingCount;
    data['parent_id'] = parentId;
    data['purchase_note'] = purchaseNote;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['menu_order'] = menuOrder;
    data['price_html'] = priceHtml;
    data['related_ids'] = relatedIds;
    if (metaData != null) {
      data['meta_data'] = metaData!.map((v) => v.toJson()).toList();
    }
    data['stock_status'] = stockStatus;
    data['has_options'] = hasOptions;
    data['post_password'] = postPassword;
    data['wooqr_code'] = wooqrCode;
    if (lLinks != null) {
      data['_links'] = lLinks!.toJson();
    }
    return data;
  }
}

class Dimensions {
  String? length;
  String? width;
  String? height;

  Dimensions({this.length, this.width, this.height});

  Dimensions.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? slug;

  Categories({this.id, this.name, this.slug});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    return data;
  }
}

class Images {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;

  Images({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.src,
    this.name,
    this.alt,
  });

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['date_created'] = dateCreated;
    data['date_created_gmt'] = dateCreatedGmt;
    data['date_modified'] = dateModified;
    data['date_modified_gmt'] = dateModifiedGmt;
    data['src'] = src;
    data['name'] = name;
    data['alt'] = alt;
    return data;
  }
}

class MetaData {
  int? id;
  String? key;
  String? value;

  MetaData({this.id, this.key, this.value});

  MetaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class Links {
  List<Self>? self;
  List<Collection>? collection;

  Links({this.self, this.collection});

  Links.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = [];
      json['self'].forEach((v) {
        self!.add(Self.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = [];
      json['collection'].forEach((v) {
        collection!.add(Collection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (self != null) {
      data['self'] = self!.map((v) => v.toJson()).toList();
    }
    if (collection != null) {
      data['collection'] = collection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['href'] = href;
    return data;
  }
}

class Collection {
  String? href;

  Collection({this.href});

  Collection.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['href'] = href;
    return data;
  }
}
