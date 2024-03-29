import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:word_trivia/core/error/exceptions.dart';
import 'package:word_trivia/core/error/failures.dart';
import 'package:word_trivia/core/network/network_info.dart';
import 'package:word_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:word_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:word_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:word_trivia/features/number_trivia/domain/repositories/number_trivia_repositories.dart';

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    return await _getNumberTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getNumberTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  // attempt at duplication reduction using higher order function
  Future<Either<Failure, NumberTrivia>> _getNumberTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
