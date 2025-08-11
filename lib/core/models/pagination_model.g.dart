// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationModel<T> _$PaginationModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginationModel<T>(
      totalCount: (json['TotalCount'] as num).toInt(),
      pageNumber: (json['PageNumber'] as num).toInt(),
      pageSize: (json['PageSize'] as num).toInt(),
      totalPages: (json['TotalPages'] as num).toInt(),
      hasPreviousPage: json['HasPreviousPage'] as bool,
      hasNextPage: json['HasNextPage'] as bool,
      list: (json['Data'] as List<dynamic>).map(fromJsonT).toList(),
    );
