import 'package:copy_with_extension/copy_with_extension.dart';

part 'base_entity.g.dart';

@CopyWith()
class BaseEntity {
  final int id;

  BaseEntity({required this.id});
}
