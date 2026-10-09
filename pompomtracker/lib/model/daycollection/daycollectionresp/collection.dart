import 'package:json_annotation/json_annotation.dart';

part 'collection.g.dart';

@JsonSerializable()
class Collection {
  @JsonKey(name: 'bus_id')
  String? busId;
  @JsonKey(name: 'bus_name')
  String? busName;
  @JsonKey(name: 'registration_no')
  String? registrationNo;
  @JsonKey(name: 'total_amount')
  dynamic totalAmount;
  @JsonKey(name: 'collection_date')
  String? collectionDate;
  @JsonKey(name: 'total_expense')
  dynamic totalExpense;

  Collection(
      {this.busId,
      this.busName,
      this.registrationNo,
      this.totalAmount,
      this.collectionDate,
      this.totalExpense});

  factory Collection.fromJson(Map<String, dynamic> json) {
    return _$CollectionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}
