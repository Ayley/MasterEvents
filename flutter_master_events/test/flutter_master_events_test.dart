import 'package:flutter_master_events/event.dart';
import 'package:flutter_master_events/event_bus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds one to input values', () {

    //Declare function to unfollow
    unfollowFunction(event) {
      print('Unfollow test');
    }

    //Follow normal
    EventBus().follow<TestEvent>((event) {
      print(event.testString);
    });

    //Follow unfollowFunction and print
    EventBus().follow<TestEvent>(unfollowFunction);

    //Unfollow unfollowFunction
    EventBus().unfollowCallback<TestEvent>(unfollowFunction);

    //The unfollowFunction should not be triggered
    EventBus().follow<TestEvent>(unfollowFunction);

    //throw exception
    EventBus().follow<TestEvent>((event) {
      throw Exception('Test exception');
    });

    //After an exception all events are triggered with an error
    EventBus().follow<TestEvent>((event) {
      print(event.error.toString());
    });

    //Cancel all functions after this event
    EventBus().follow<TestEvent>((event) {
      print('Cancel all functions after');
      event.cancel = true;
    });

    //This is canceled
    EventBus().follow<TestEvent>((event) {
      print("Canceled event shouldn't triggered");
    });

    //After an exception all events are triggered with an error
    //But these are also canceled
    EventBus().follow<TestEvent>((event) {
      print(event.error.toString());
    });

    EventBus().broadcast<TestEvent>(TestEvent('Hello World!'));
  });
}

class TestEvent extends Event {
  String testString;

  TestEvent(this.testString);
}
