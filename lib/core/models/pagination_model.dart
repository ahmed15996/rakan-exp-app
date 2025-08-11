import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class PaginationModel<T> {
  @JsonKey(name: "TotalCount")
  final int totalCount;
  @JsonKey(name: "PageNumber")
  final int pageNumber;
  @JsonKey(name: "PageSize")
  final int pageSize;
  @JsonKey(name: "TotalPages")
  final int totalPages;
  @JsonKey(name: "HasPreviousPage")
  final bool hasPreviousPage;
  @JsonKey(name: "HasNextPage")
  final bool hasNextPage;
  @JsonKey(name: "Data")
  final List<T> list;

  PaginationModel({
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
    required this.list,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PaginationModelFromJson(json, fromJsonT);
}


