import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:either_dart/either.dart';

part 'result.g.dart';

enum ErrorCode {
  noDescription(code: '500', message: 'unKnown');

  final String code;
  final String message;

  const ErrorCode({required this.code, required this.message});
}

/// usecase의 return type
typedef Result<T> = Either<Failure, T>;

@CopyWith(copyWithNull: true)
class Failure {
  final ErrorCode errorCode;
  final String? message;

  const Failure({
    this.errorCode = ErrorCode.noDescription,
    this.message = 'error',
  });
}
