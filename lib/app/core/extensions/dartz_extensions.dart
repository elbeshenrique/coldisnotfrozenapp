import 'package:dartz/dartz.dart';

extension DartzExtensions<L, R> on Either<L, R> {
  R foldAlwaysRight(Function handleLeft) {
    R rightValue;
    this.fold(
      (left) {
        handleLeft(left);
        return null;
      },
      (right) {
        rightValue = right;
      },
    );

    return rightValue;
  }
}
