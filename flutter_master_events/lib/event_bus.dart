import 'package:flutter_master_events/event.dart';

class EventBus {
  factory EventBus() => _instance;

  EventBus._internal();

  static final EventBus _instance = EventBus._internal();

  final Map<String, List<dynamic>> _controllers = {};

  void follow<T extends Event>(OnEvent<T> callback) {
    if (!_controllers.containsKey(T.toString())) {
      _controllers[T.toString()] = <dynamic>[];
    }

    _controllers[T.toString()]!.add(callback);
  }

  void unfollowEvent<T extends Event>(){
    if (!_controllers.containsKey(T.toString())) {
      return;
    }

    _controllers.remove(T.toString());
  }

  void unfollowCallback<T extends Event>(OnEvent<T> callback){
    if (!_controllers.containsKey(T.toString())) {
      return;
    }

    _controllers.forEach((key, value) { value.removeWhere((element) => element == callback); });
  }

  void broadcast<T extends Event>(T event) {
    if (!_controllers.containsKey(T.toString())) {
      return;
    }

    for (final on in _controllers[T.toString()]!) {
      try {
        if (!event.cancel) {
          on(event);
        }

      } catch (err) {
        event.error = err;
      }
    }
  }
}

typedef OnEvent<T extends Event> = void Function(T event);
