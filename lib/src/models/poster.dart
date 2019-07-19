import 'package:json_annotation/json_annotation.dart';

import 'model.dart';

part 'poster.g.dart';

@JsonSerializable()
class PosterBase {
  int pk;
  String theme;
  String text;
  num price;
  num currency;
  List<PosterImage> images;
  @JsonKey(name: 'contract_price')
  bool contractPrice;
  String location;
  String category;
  @JsonKey(name: 'activated_at')
  String activatedAt;
  @JsonKey(name: 'is_active')
  bool isActive;

  PosterBase(
      this.pk,
      this.theme,
      this.text,
      this.price,
      this.currency,
      this.images,
      this.contractPrice,
      this.location,
      this.category,
      this.activatedAt,
      this.isActive);

  factory PosterBase.fromJson(Map<String, dynamic> json) =>
      _$PosterBaseFromJson(json);

  Map<String, dynamic> toJson() => _$PosterBaseToJson(this);
}

@JsonSerializable()
class PosterResponse extends PosterBase {
  User owner;

  PosterResponse(
      int pk,
      this.owner,
      String theme,
      String text,
      num price,
      num currency,
      List<PosterImage> images,
      bool contractPrice,
      String location,
      String category,
      String activatedAt,
      bool isActive)
      : super(pk, theme, text, price, currency, images, contractPrice, location,
            category, activatedAt, isActive);

  factory PosterResponse.fromJson(Map<String, dynamic> json) =>
      _$PosterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PosterResponseToJson(this);
}

class PosterNormalized extends PosterBase {
  String ownerId;

  PosterNormalized(
      int pk,
      this.ownerId,
      String theme,
      String text,
      num price,
      num currency,
      List<PosterImage> images,
      bool contractPrice,
      String location,
      String category,
      String activatedAt,
      bool isActive)
      : super(pk, theme, text, price, currency, images, contractPrice, location,
            category, activatedAt, isActive);
}

@JsonSerializable()
class PosterImage {
  int pk;
  int advert;
  String file;

  PosterImage(this.pk, this.advert, this.file);

  factory PosterImage.fromJson(Map<String, dynamic> json) =>
      _$PosterImageFromJson(json);

  Map<String, dynamic> toJson() => _$PosterImageToJson(this);
}

@JsonSerializable()
class PosterMeta {
  int total;
  int page;
  @JsonKey(name: 'per_page')
  int perPage;

  PosterMeta(this.total, this.page, this.perPage);

  factory PosterMeta.fromJson(Map<String, dynamic> json) =>
      _$PosterMetaFromJson(json);

  Map<String, dynamic> toJson() => _$PosterMetaToJson(this);
}

@JsonSerializable()
class PostersFetchResponse {
  PosterMeta meta;
  List<PosterResponse> data;

  PostersFetchResponse(this.meta, this.data);

  factory PostersFetchResponse.fromJson(Map<String, dynamic> json) =>
      _$PostersFetchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostersFetchResponseToJson(this);
}
