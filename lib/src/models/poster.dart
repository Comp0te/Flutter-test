import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'model.dart';

part 'poster.g.dart';

@JsonSerializable()
class PosterBase {
  @JsonKey(name: 'pk')
  int id;
  String theme;
  String text;
  num price;
  num currency;
  List<PosterImage> images;
  @JsonKey(name: 'contract_price')
  bool contractPrice;
  dynamic location;
  String category;
  @JsonKey(name: 'activated_at')
  String activatedAt;
  @JsonKey(name: 'is_active')
  bool isActive;

  PosterBase(
      this.id,
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
      int id,
      this.owner,
      String theme,
      String text,
      num price,
      num currency,
      List<PosterImage> images,
      bool contractPrice,
      int location,
      String category,
      String activatedAt,
      bool isActive)
      : super(id, theme, text, price, currency, images, contractPrice, location,
            category, activatedAt, isActive);

  factory PosterResponse.fromJson(Map<String, dynamic> json) =>
      _$PosterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PosterResponseToJson(this);
}

@JsonSerializable()
class PosterNormalized extends PosterBase {
  int ownerId;

  PosterNormalized({
    @required int id,
    @required this.ownerId,
    @required String theme,
    @required String text,
    @required num price,
    @required num currency,
    @required List<PosterImage> images,
    @required bool contractPrice,
    @required dynamic location,
    @required String category,
    @required String activatedAt,
    @required bool isActive,
  }) : super(id, theme, text, price, currency, images, contractPrice, location,
            category, activatedAt, isActive);

  factory PosterNormalized.fromJson(Map<String, dynamic> json) =>
      _$PosterNormalizedFromJson(json);

  Map<String, dynamic> toJson() => _$PosterNormalizedToJson(this);
}

@JsonSerializable()
class PosterImage {
  @JsonKey(name: 'pk')
  int id;
  int advert;
  String file;

  PosterImage(this.id, this.advert, this.file);

  factory PosterImage.fromJson(Map<String, dynamic> json) =>
      _$PosterImageFromJson(json);

  Map<String, dynamic> toJson() => _$PosterImageToJson(this);
}

@JsonSerializable()
class PosterImageDB extends PosterImage {
  int posterId;

  PosterImageDB({
    @required int id,
    @required int advert,
    @required String file,
    @required this.posterId,
  }) : super(id, advert, file);

  factory PosterImageDB.fromJson(Map<String, dynamic> json) =>
      _$PosterImageDBFromJson(json);

  Map<String, dynamic> toJson() => _$PosterImageDBToJson(this);
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
