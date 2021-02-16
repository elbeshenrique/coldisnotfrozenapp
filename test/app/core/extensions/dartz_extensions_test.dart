import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:guard_class/app/core/extensions/dartz_extensions.dart';
import 'package:mockito/mockito.dart';

main() {
  final Either<Exception, String> leftExceptionMock = Left(Exception());
  final Either<Exception, String> leftNullMock = Left(null);

  final Either<Exception, String> rightStringMock = Right("");
  final Either<Exception, String> rightNullMock = Right(null);

  final handleExceptionMock = (_) {};

  group("getRight", () {
    test("rightStringMock should return an object", () {
      final result = rightStringMock.getRight();
      expect(result, isA<String>());
    });
    test("rightNullMock should return an object", () {
      final result = rightNullMock.getRight();
      expect(result, null);
    });

    test("leftExceptionMock should return null", () {
      final result = leftExceptionMock.getRight();
      expect(result, null);
    });
    test("leftNullMock should return null", () {
      final result = leftNullMock.getRight();
      expect(result, null);
    });

    test("leftExceptionMock should return null when passed a handleException function", () {
      final result = leftExceptionMock.getRight(handleExceptionMock);
      expect(result, null);
    });
    test("leftNullMock should return null when passed a handleException function", () {
      final result = leftNullMock.getRight(handleExceptionMock);
      expect(result, null);
    });
  });

  group("getLeft", () {
    test("leftExceptionMock should return an Exception", () {
      final result = leftExceptionMock.getLeft();
      expect(result, isA<Exception>());
    });
    test("leftNullMock should return null", () {
      final result = leftNullMock.getLeft();
      expect(result, null);
    });

    test("rightStringMock should return an object", () {
      final result = rightStringMock.getLeft();
      expect(result, null);
    });
    test("rightNullMock should return an object", () {
      final result = rightNullMock.getLeft();
      expect(result, null);
    });
  });

  group("isFailure", () {
    test("leftExceptionMock should return true", () {
      final result = leftExceptionMock.isFailure();
      expect(result, true);
    });
    test("leftNullMock should return true", () {
      final result = leftNullMock.isFailure();
      expect(result, true);
    });
    test("leftExceptionMock should return true when passed a handleException function", () {
      final result = leftExceptionMock.isFailure(handleExceptionMock);
      expect(result, true);
    });
    test("leftNullMock should return true when passed a handleException function", () {
      final result = leftNullMock.isFailure(handleExceptionMock);
      expect(result, true);
    });

    test("rightStringMock should return false", () {
      final result = rightStringMock.isFailure();
      expect(result, false);
    });
    test("rightNullMock should return false", () {
      final result = rightNullMock.isFailure();
      expect(result, false);
    });
    test("rightStringMock should return false when passed a handleException function", () {
      final result = rightStringMock.isFailure(handleExceptionMock);
      expect(result, false);
    });
    test("rightNullMock should return false when passed a handleException function", () {
      final result = rightNullMock.isFailure(handleExceptionMock);
      expect(result, false);
    });
  });
}
