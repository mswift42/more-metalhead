// world.dart - class representation of rooms, items and the player.

class Direction {
  String _direction;
  Direction(this._direction);

  String get direction {
    return _directionMap[_direction.toLowerCase()];
  }
}

final Map<String, String> _directionMap = {
  'n': 'north',
  'north': 'north',
  'nw': 'northwest',
  'northwest': 'northwest',
  'w': 'west',
  'west': 'west',
  'sw': 'southwest',
  'southwest': 'southwest',
  's': 'south',
  'south': 'south',
  'se': 'southeast',
  'southeast': 'southeast',
  'e': 'east',
  'east': 'east',
  'ne': 'northeast',
  'northeast': 'northeast',
  'u': 'up',
  'up': 'up',
  'd': 'down',
  'down': 'down'
};

class Location {
  String _name;
  List<String> _longDescription;
  List<String> _shortDescription;
  Map<Direction, Exit> _exits;
  Map<String, bool> _flags;
  List<Item> _items;

  Location(this._name,  this._longDescription, this._shortDescription,
      this._exits, this._flags, this._items);

  String get name => _name;
  List<String> get longDescription => _longDescription;

  List<String> get shortDescription => _shortDescription;

  Map<Direction, Exit> get exits => _exits;

  Map<String, bool> get flags => _flags;

  List<Item> get items => _items;
}

class Item {
  String _name;
  List<String> _synonyms;
  List<String> _firstDescription;
  List<String> _longDescription;
  List<String> _shortDescription;
  Map<InputCmd, ExecCmd> _actions;
  Map<String, bool> _flags;

  String get name => _name;

  Item(
      this._name,
      this._synonyms,
      this._firstDescription,
      this._longDescription,
      this._shortDescription,
      this._actions,
      this._flags);

  List<String> get synonyms => _synonyms;

  List<String> get firstDescription => _firstDescription;

  List<String> get longDescription => _longDescription;

  List<String> get shortDescription => _shortDescription;

  Map<InputCmd, ExecCmd> get actions => _actions;

  Map<String, bool> get flags => _flags;
}
// The Player class represents the players status in the game. It contains
// the player's current location and lists all Items in the player's inventory.
class Player {
  Location _location;
  List<Item> _inventory = [];

  Location get location => _location;

  set location(Location value) => _location = value;

  List<Item> get inventory => _inventory;

  addItem(Item item) => _inventory.add(item);

  dropItem(Item item) => _inventory.remove(item);

}

enum Exit { CondExit, UnCondExit, NoExit }

class CondExit {
  Location _nextloc;
  Map<String, bool> _condition;

  CondExit(this._nextloc, this._condition);

  Map<String, bool> get condition => _condition;

  Location get nextloc => _nextloc;

}

class UnCondExit {
  Location _nextloc;

  UnCondExit(this._nextloc);

  Location get nextloc => _nextloc;
}

class NoExit {
  List<String> _noexittext;

  NoExit(this._noexittext);

  List<String> get noexittext => _noexittext;
}

class Command {
  String _command;

  Command(this._command);

  String get command => _command;
}

class InputCmd extends Command {
  InputCmd(String _command) : super(_command);
}

class ExecCmd extends Command {
  ExecCmd(String _command) : super(_command);
}
