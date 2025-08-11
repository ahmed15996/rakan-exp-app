import 'package:json_annotation/json_annotation.dart';

part 'document_model.g.dart';

@JsonSerializable(createToJson: false)
class DocumentModel {
  @JsonKey(name: 'Id')
  final String id;

  @JsonKey(name: 'DocumentsUrl')
  final String documentUrl;

  @JsonKey(name: 'Extension')
  final String extension;

  DocumentModel({
    required this.id,
    required this.documentUrl,
    required this.extension,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);
}
