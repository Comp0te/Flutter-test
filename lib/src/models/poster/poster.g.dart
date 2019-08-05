// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poster.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PosterBase _$PosterBaseFromJson(Map<String, dynamic> json) {
  return PosterBase(
    json['pk'] as int,
    json['theme'] as String,
    json['text'] as String,
    json['price'] as num,
    json['currency'] as num,
    json['contract_price'] as bool,
    json['location'],
    json['category'] as String,
    json['activated_at'] as String,
    json['is_active'] as bool,
  );
}

Map<String, dynamic> _$PosterBaseToJson(PosterBase instance) =>
    <String, dynamic>{
      'pk': instance.id,
      'theme': instance.theme,
      'text': instance.text,
      'price': instance.price,
      'currency': instance.currency,
      'contract_price': instance.contractPrice,
      'location': instance.location,
      'category': instance.category,
      'activated_at': instance.activatedAt,
      'is_active': instance.isActive,
    };

PosterResponse _$PosterResponseFromJson(Map<String, dynamic> json) {
  return PosterResponse(
    json['pk'] as int,
    json['owner'] == null
        ? null
        : User.fromJson(json['owner'] as Map<String, dynamic>),
    json['theme'] as String,
    json['text'] as String,
    json['price'] as num,
    json['currency'] as num,
    (json['images'] as List)
        ?.map((e) =>
            e == null ? null : PosterImage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['contract_price'] as bool,
    json['location'] as int,
    json['category'] as String,
    json['activated_at'] as String,
    json['is_active'] as bool,
  );
}

Map<String, dynamic> _$PosterResponseToJson(PosterResponse instance) =>
    <String, dynamic>{
      'pk': instance.id,
      'theme': instance.theme,
      'text': instance.text,
      'price': instance.price,
      'currency': instance.currency,
      'contract_price': instance.contractPrice,
      'location': instance.location,
      'category': instance.category,
      'activated_at': instance.activatedAt,
      'is_active': instance.isActive,
      'images': instance.images,
      'owner': instance.owner,
    };

PosterNormalized _$PosterNormalizedFromJson(Map<String, dynamic> json) {
  return PosterNormalized(
    id: json['pk'] as int,
    ownerId: json['ownerId'] as int,
    theme: json['theme'] as String,
    text: json['text'] as String,
    price: json['price'] as num,
    currency: json['currency'] as num,
    images: (json['images'] as List)
        ?.map((e) =>
            e == null ? null : PosterImage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    contractPrice: json['contract_price'] as bool,
    location: json['location'],
    category: json['category'] as String,
    activatedAt: json['activated_at'] as String,
    isActive: json['is_active'] as bool,
  );
}

Map<String, dynamic> _$PosterNormalizedToJson(PosterNormalized instance) =>
    <String, dynamic>{
      'pk': instance.id,
      'theme': instance.theme,
      'text': instance.text,
      'price': instance.price,
      'currency': instance.currency,
      'contract_price': instance.contractPrice,
      'location': instance.location,
      'category': instance.category,
      'activated_at': instance.activatedAt,
      'is_active': instance.isActive,
      'ownerId': instance.ownerId,
      'images': instance.images,
    };

PosterNormalizedDB _$PosterNormalizedDBFromJson(Map<String, dynamic> json) {
  return PosterNormalizedDB(
    json['activated_at'] as String,
    json['category'] as String,
    json['contract_price'] as int,
    json['currency'] as num,
    json['pk'] as int,
    json['is_active'] as int,
    json['location'],
    json['ownerId'] as int,
    json['price'] as num,
    json['text'] as String,
    json['theme'] as String,
  );
}

Map<String, dynamic> _$PosterNormalizedDBToJson(PosterNormalizedDB instance) =>
    <String, dynamic>{
      'activated_at': instance.activatedAt,
      'category': instance.category,
      'contract_price': instance.contractPrice,
      'currency': instance.currency,
      'pk': instance.id,
      'is_active': instance.isActive,
      'location': instance.location,
      'ownerId': instance.ownerId,
      'price': instance.price,
      'text': instance.text,
      'theme': instance.theme,
    };

PosterImage _$PosterImageFromJson(Map<String, dynamic> json) {
  return PosterImage(
    json['pk'] as int,
    json['advert'] as int,
    json['file'] as String,
  );
}

Map<String, dynamic> _$PosterImageToJson(PosterImage instance) =>
    <String, dynamic>{
      'pk': instance.id,
      'advert': instance.advert,
      'file': instance.file,
    };

PosterImageDB _$PosterImageDBFromJson(Map<String, dynamic> json) {
  return PosterImageDB(
    id: json['pk'] as int,
    advert: json['advert'] as int,
    file: json['file'] as String,
    posterId: json['posterId'] as int,
  );
}

Map<String, dynamic> _$PosterImageDBToJson(PosterImageDB instance) =>
    <String, dynamic>{
      'pk': instance.id,
      'advert': instance.advert,
      'file': instance.file,
      'posterId': instance.posterId,
    };

PosterMeta _$PosterMetaFromJson(Map<String, dynamic> json) {
  return PosterMeta(
    json['total'] as int,
    json['page'] as int,
    json['per_page'] as int,
  );
}

Map<String, dynamic> _$PosterMetaToJson(PosterMeta instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'per_page': instance.perPage,
    };

PostersFetchResponse _$PostersFetchResponseFromJson(Map<String, dynamic> json) {
  return PostersFetchResponse(
    json['meta'] == null
        ? null
        : PosterMeta.fromJson(json['meta'] as Map<String, dynamic>),
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : PosterResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PostersFetchResponseToJson(
        PostersFetchResponse instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'data': instance.data,
    };
