

import 'dart:async';

class CountBLoC {
  int _count;
  StreamController<int> _countController;

  CountBLoC(){
    _count = 0;
    _countController = StreamController<int>();

  }

  Stream<int> get value=> _countController.stream;

  increment(){
    _countController.sink.add(++_count);

  }

  dispose(){
    _countController.close();
  }


}