import 'dart:io';

abstract class ImageRepository {
  Future<String> saveImage(File file);

  Future<String> changeImage({
    required File file,
    required String originalPath,
  });

  Future<void> deleteImage(String path);
}
