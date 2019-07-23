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
    (json['images'] as List)
        ?.map((e) =>
            e == null ? null : PosterImage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
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
      'images': instance.images,
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
      'images': instance.images,
      'contract_price': instance.contractPrice,
      'location': instance.location,
      'category': instance.category,
      'activated_at': instance.activatedAt,
      'is_active': instance.isActive,
      'owner': instance.owner,
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
