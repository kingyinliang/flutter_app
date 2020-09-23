import 'package:event_bus/event_bus.dart';

class MsgEvent {
  Map<String, dynamic> msg;

  MsgEvent(this.msg);
}

class EventBusUtil {
  static EventBus _eventBus;

  static EventBus getInstance() {
    if (_eventBus == null) {
      _eventBus = new EventBus();
    }
    return _eventBus;
  }
}
