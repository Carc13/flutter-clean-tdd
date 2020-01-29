import 'package:clean_tdd/core/presentation/util/input_converter.dart';
import 'package:clean_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_tdd/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockGetConcreteNumberTrivia extends Mock implements GetConcreteNumberTrivia{}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia{}

class MockInputConvert extends Mock implements InputConverter {}

void main(){
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConvert mockInputConvert;


  setUp((){
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConvert = MockInputConvert();

    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      random:mockGetRandomNumberTrivia,
      inputConverter: mockInputConvert 
    );
  });

  test('initialState should be Empty', (){
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', (){
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    test(
      'should call the InputConverter to validate and convert the string to an unsigned integer',
      () async {
        when(mockInputConvert.stringToUnsignedInterger(any))
          .thenReturn(Right(tNumberParsed));

        bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockInputConvert.stringToUnsignedInterger(any));

        verify(mockInputConvert.stringToUnsignedInterger(tNumberString));

      }
    );

    test(
      'should emit [Error] when the input is invalid',
      () async {
        when(mockInputConvert.stringToUnsignedInterger(any))
          .thenReturn(Left(InvalidInputFailure()));

        final expected = [ Empty(),
            Error(message: INVALID_INPUT_FAILURE_MESSAGE)];

        expectLater(bloc.state, emitsInOrder(expected));
        
        bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
        
      }
    );



  });


}