import 'package:dartz/dartz.dart';

extension DartzExtensions<L extends Exception, R> on Either<L, R> {
  R getRight([Function handleLeft]) {
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
      id,
    );

    return leftValue;
  }

  

  bool isFailure(Function(Exception) handleException) {
    if (isLeft()) {
      handleException(this.getLeft());
      return true;
    }

    return false;
  }
}
