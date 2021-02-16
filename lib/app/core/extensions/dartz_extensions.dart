import 'package:dartz/dartz.dart';

extension DartzExtensions<L extends Exception, R> on Either<L, R> {
  R getRight([Function(L) handleLeft]) {
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

  L getLeft() {
    L leftValue;
    this.fold(
      (left) {
        leftValue = left;
      },
      (right) {
        leftValue = null;
      },
    );

    return leftValue;
  }

  bool isFailure([Function(L) handleException]) {
    if (isLeft()) {
      handleException?.call(this.getLeft());
      return true;
    }

    return false;
  }
}
