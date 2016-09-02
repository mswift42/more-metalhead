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
  String name;
  List<String> longDescription;
  List<String> shortDescription;
  Map<Direction, dynamic> exits;
  Map<String, bool> flags = {};
  List<Item> items = [];
  List<NPC> npcs = [];

  List<String> get description {
    if (flags["visited"]) {
      return shortDescription;
    }
    return longDescription;
  }

  addItem(Item item) {
    items.add(item);
  }

  removeItem(Item item) {
    items.remove(item);
  }
}

abstract class WorldObject {
  String _name;
  List<String> _synonyms;
  List<String> _firstDescription;
  List<String> _longDescription;
  List<String> _shortDescription;
  Map<InputCmd, ExecCmd> _actions;
  Map<String, bool> _flags;

  String get name => _name;

  set name(String value) => _name = value;

  List<String> get synonyms => _synonyms;

  set synonyms(List<String> value) => _synonyms = value;

  List<String> get firstDescription => _firstDescription;

  set firstDescription(List<String> value) => _firstDescription = value;

  List<String> get longDescription => _longDescription;

  set longDescription(List<String> value) => _longDescription = value;

  List<String> get shortDescription => _shortDescription;

  set shortDescription(List<String> value) => _shortDescription = value;

  Map<InputCmd, ExecCmd> get actions => _actions;

  set actions(Map<InputCmd, ExecCmd> value) => _actions = value;

  Map<String, bool> get flags => _flags;

  set flags(Map<String, bool> value) => _flags = value;
}

class Item extends WorldObject {}

class NPC extends WorldObject {}

// The Player class represents the players status in the game. It contains
// the player's current location and lists all Items in the player's inventory.
class Player {
  Location _location;
  List<Item> _inventory = [];
  Map<String, bool> _flags = {};

  setVisited() {
    _flags[visitedFlagName(_location.name)] = true;
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

  bool flagStatus(String flag) => _flags[flag];

  setFlagStatus(String flag, bool status) {
    _flags[flag] = status;
  }

  String visitedFlagName(String locationname) {
    return "visited" + camelCaseName(locationname);
  }

  String camelCaseName(String locationname) {
    var name = locationname[0].toUpperCase();
    for (var i = 1; i < locationname.length; i++) {
      if (locationname[i] == " ") {
        return name += camelCaseName(locationname.substring(i + 1));
      }
      name += locationname[i];
    }
    return name;
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
