import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@module
abstract class LocalDataSourceModule {}

@module
abstract class RemoteDataSourceModule {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
}
