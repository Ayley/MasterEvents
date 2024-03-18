## flutter_master_events
Simple implementation for events

```
    //Follow event
    EventBus().follow<StringEvent>((event) => print(event.string));
    
    //Broadcast event (Call/trigger the event)
    EventBus().broadcast<StringEvent>(StringEvent('Hello World!!!'));
    
    //Unfollow event
    EventBus().unfollow<StringEvent>();
    
    //Unfollow callback
    EventBus().unfollow<StringEvent>((event) => print(event.string));
    
    class StringEvent extends Event {
    
      StringEvent(this.string);
    
      String string;

    }
```
