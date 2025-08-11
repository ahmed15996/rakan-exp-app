import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

enum PickImageFromEnum { camera, gallery }

@injectable
class DocumentHelper {
  final ImagePicker imagePicker;

  DocumentHelper({required this.imagePicker});

  static File? pickedImage;

  Future<File?> pickImage({
    required PickImageFromEnum type,
    required bool isCompress,
  }) async {
    late XFile? photo;
    endUploadImage();
    if (type == PickImageFromEnum.camera) {
      photo = await imagePicker.pickImage(source: ImageSource.camera);
    } else {
      photo = await imagePicker.pickImage(source: ImageSource.gallery);
    }
    if (photo != null) {
      if (isCompress) {
        pickedImage = await compressImage(xFile: photo);
        return pickedImage;
      } else {
        pickedImage = File(photo.path);
        return pickedImage;
      }
    } else {
      return null;
    }
  }



  Future<File> compressImage({required XFile xFile}) async {
    Uint8List? uint8list = await FlutterImageCompress.compressWithFile(
      xFile.path,
      quality: 90,
      minWidth: 800,
      minHeight: 600,
    );
    final tempDir = await getTemporaryDirectory();
    // final tempDir = await getApplicationDocumentsDirectory();
    final compressedFilePath =
    join(tempDir.path, 'compressed_${basename(xFile.path)}');
    File compressedFile = File(compressedFilePath);
    await compressedFile.writeAsBytes(uint8list!);

    return compressedFile;
  }

  void endUploadImage() {
    pickedImage = null;
  }


}
