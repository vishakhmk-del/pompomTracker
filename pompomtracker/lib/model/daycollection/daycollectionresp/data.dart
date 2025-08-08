import 'package:json_annotation/json_annotation.dart';

import 'collection.dart';

part 'data.g.dart';

@JsonSerializable()
class DataCollection {
  List<Collection>? collection;
  @JsonKey(name: 'grand_total')
  dynamic grandTotal;
  @JsonKey(name: 'collection_date')
  String? collectionDate;

  DataCollection({this.collection, this.grandTotal, this.collectionDate});

  factory DataCollection.fromJson(Map<String, dynamic> json) =>
      _$DataCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$DataCollectionToJson(this);
}
