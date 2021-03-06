
import 'dart:convert';

import 'package:clean_tdd/core/error/exceptions.dart';
import 'package:clean_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const CACHED_NUMBER_TRIVIA = "CACHED_NUMBER_TRIVIA";


class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({
    @required this.sharedPreferences
  });

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final String jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if(jsonString != null ){
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    }else {
       throw CacheException(); 
    }
   
  }
  
  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA, 
      json.encode(triviaToCache.toJson()),
    );
  }

}