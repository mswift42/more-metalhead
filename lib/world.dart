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
  Map<Direction, dynamic> _exits;
  Map<String, bool> _flags;
  List<Item> _items;

  Location(this._name, this._longDescription, this._shortDescription,
      this._exits, this._flags, this._items);

  String get name => _name;
  List<String> get longDescription => _longDescription;

  List<String> get shortDescription => _shortDescription;

  List<String> get description {
    if (_flags["visited"]) {
      return _shortDescription;
    }
    return _longDescription;
  }

  addItem(Item item) {
    _items.add(item);
  }

  removeItem(Item item) {
    _items.remove(item);
  }

  Map<Direction, dynamic> get exits => _exits;

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
  Map<String, bool> _flags = {};

  setVisited() {
    var loc = _location.name;
    var capitalized = 'hasVisited${loc[0].toUpperCase()}${loc.substring((1))}';
    _location.flags[capitalized] = true;
  }

  Location get location => _location;

  set location(Location value) => _location = value;

  List<String> moveInDirection(Direction dir) {
    var nloc = _location.exits[dir];
    if (nloc is UnCondExit) {
      setVisited();
      location = nloc.nextloc;
      return location.description;
    }
    if (nloc is NoExit) {
      return nloc.noexittext;
    }
    if (nloc is CondExit) {
      if (nloc.meetsAllConditions()) {
        location = nloc.nextloc;
        setVisited();
        return location.description;
      }
      return nloc.failtext;
    }
  }

  List<Item> get inventory => _inventory;

  addItem(Item item) {
    _inventory.add(item);
    _location.removeItem(item);
  }

  dropItem(Item item) {
    _inventory.remove(item);
    _location.addItem(item);
  }
}

class CondExit {
  Location _nextloc;
  Map<String, bool> _condition;
  List<String> _failtext;

  CondExit(this._nextloc, this._condition, this._failtext);

  Map<String, bool> get condition => _condition;

  bool meetsAllConditions() {
    return _condition.keys.every((i) => (_condition[i] == true));
  }

  Location get nextloc => _nextloc;

  List<String> get failtext => _failtext;
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
