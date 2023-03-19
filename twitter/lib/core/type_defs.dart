import 'package:fpdart/fpdart.dart';
import 'package:twitter/core/faliure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
