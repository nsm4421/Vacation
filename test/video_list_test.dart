import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:vacation/data/models/export.dart';
import 'package:vacation/env.dart';

void main() async {
  final logger = Logger();

  group('YouTube API with Dio', () {
    test('testYoutubeApiWithDio returns non-null result', () async {
      const query = 'flutter';
      final result = await testYoutubeApiWithDio(query);
      if (result != null) {
        for (final e in result) {
          logger.d(e);
        }
      }
      expect(result, isNotNull);
    });
  });
}

Future<Iterable<dynamic>?> testYoutubeApiWithDio(String query) async {
  final logger = Logger();
  final dio = Dio();
  final url = 'https://www.googleapis.com/youtube/v3/search';
  final params = {
    ...SearchVideoReqModel(q: query).toJson(),
    'key': Env.youtubeApiKey,
  };

  try {
    final items = await dio
        .get(url, queryParameters: params)
        .then((res) => (res.data as Map<String, dynamic>))
        .then(SearchVideoResModel.fromJson)
        .then((json) => json.items);
    return items;
  } catch (e) {
    logger.e("❌ 요청 실패: $e");
    return null;
  }
}
