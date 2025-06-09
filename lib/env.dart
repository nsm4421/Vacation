import 'package:envied/envied.dart';

part 'env.g.dart';

/// 환경변수 주입
@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'DB_NAME')
  static const String dbName = _Env.dbName;
  @EnviedField(varName: 'YOUTUBE_API_KEY')
  static const String youtubeApiKey = _Env.youtubeApiKey;
}
