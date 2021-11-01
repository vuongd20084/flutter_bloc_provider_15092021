
import 'dart:async';

import 'package:flutter_bloc_provider_15092021/bloc/search_event.dart';
import 'package:flutter_bloc_provider_15092021/bloc/search_state.dart';

class SearchBloc{
  var state = SearchState(listLanguage: [
    "ANDROID",
    "IOS",
    "PHP",
    "JAVASCRIPT",
    "GOLANG",
    "DART",
    "FLUTTER",
    "VUEJS",
    "TYPESCRIPT",
    "test 1",
    "test 2",
    "test 3",
    "test 4",
    "test 5",
  ]);

  StreamController<SearchEvent> eventController  = StreamController();
  StreamController<SearchState> stateController = StreamController();


  SearchBloc(){
    eventController.stream.listen((event) {
      if (event is QueryEvent){
        //..
        filter(event.query);
      }
    });
  }

  void filter(String query){
    if (query.isEmpty){
      stateController.sink.add(state);
      return;
    }
    Future.delayed(Duration(seconds: 1),(){
      List<String> newList = [];
      state.listLanguage.forEach((element) {
        if(element.toLowerCase().contains(query.toLowerCase())){
          newList.add(element);
        }
      });
      stateController.sink.add(SearchState(listLanguage: newList));
    });
  }


  void dispose(){
    eventController.close();
    stateController.close();
  }

}