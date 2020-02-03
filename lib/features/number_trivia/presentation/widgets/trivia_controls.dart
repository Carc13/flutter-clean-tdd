import 'package:clean_tdd/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key key,
  }) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  String inputStr;
  final controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          onSubmitted: (_){
            dispatchConcrete();
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(
            ),
            hintText: 'Input a number'
          ),
          onChanged: (value){
            inputStr = value;
          },
        ),
        SizedBox( height: 10,),
        Row(children: <Widget>[
          Expanded(
            child: RaisedButton(
              child: Text('Search'),
              color: Theme.of(context).accentColor,
              textTheme: ButtonTextTheme.primary,
              onPressed: dispatchConcrete,
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: RaisedButton(
              child: Text('Get randowm trivia'),
              onPressed: dispatchRandom,
            ),
          )
        ],),
      ],
    );
  }

  void dispatchConcrete(){
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).dispatch(GetTriviaForConcreteNumber(inputStr));
  }

  void dispatchRandom(){
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).dispatch(GetTriviaForRandomNumber());
  }


}



