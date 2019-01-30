import 'package:event_bus/event_bus.dart';


EventBus eventBus = new EventBus();//创建实例

class MyEvent{
  String text;
  MyEvent(this.text);
}

class ThemeColor{
    var theme;
    ThemeColor(this.theme);
}