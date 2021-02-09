import 'package:dartz/dartz.dart';

extension DartzExtensions<L, R> on Either<L, R> {
  R foldAlwaysRight([Function handleLeft]) {
    R rightValue;
    this.fold(
      (left) {
        handleLeft?.call(left);
        return null;
      },
      (right) {
        rightValue = right;
      },
    );

    return rightValue;
  }

  L foldAlwaysLeft() {
    L leftValue;
    this.fold(
      (left) {
        leftValue = left;
      },
      id,
    );

    return leftValue;
  }
}
