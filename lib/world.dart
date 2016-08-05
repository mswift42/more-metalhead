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
  'northeast': 'northeast'
};

class Location {
  String _name;
  List<String> _shortDescription;
  List<String> _longDescription;
  Map<Direction, Exit> _exits;

  Location(
      this._name, this._shortDescription, this._longDescription, this._exits);
}

enum Exit { CondExit, UnCondExit, NoExit }

class CondExit {
  Direction _direction;
  Location _nextloc;
  Map<String, bool> _condition;

  CondExit(this._direction, this._nextloc, this._condition);

  Map<String, bool> get condition => _condition;

  Location get nextloc => _nextloc;

  Direction get direction => _direction;
}

class UnCondExit {
  Direction _direction;
  Location _nextloc;

  UnCondExit(this._direction, this._nextloc);

  Location get nextloc => _nextloc;

  Direction get direction => _direction;
}

class NoExit {
  Direction _direction;
  List<String> _noexittext;

  NoExit(this._direction, this._noexittext);

  List<String> get noexittext => _noexittext;

  Direction get direction => _direction;


}
