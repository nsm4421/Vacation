import 'dart:io';

import 'package:vacation/data/datasources/export.dart';
import 'package:vacation/domain/repositories/export.dart';

class $ImageRepositoryImpl implements ImageRepository {
  final LocalStorage _localStorage;

  $ImageRepositoryImpl(this._localStorage);

  @override
  Future<String> changeImage({
    required File file,
    required String originalPath,
  }) async {
    return await _localStorage.saveFileAndReturnPath(file: file, upsert: true);
  }

  @override
  Future<void> deleteImage(String path) async {
    return await _localStorage.deleteFile(path);
  }

  @override
  Future<String> saveImage(File file) async {
    return await _localStorage.saveFileAndReturnPath(file: file, upsert: false);
  }
}
