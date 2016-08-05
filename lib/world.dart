// world.dart - class representation of rooms, items and the player.

class Direction {
  String _direction;
  Direction(this._direction);
  String get direction {
    switch (_direction) {
      case 'n':
      case 'north':
        return 'north';
        break;
      case 'w':
      case 'west':
        return 'west';
        break;
      case 's':
      case 'south':
        return 'south';
        break;
      case 'e':
      case 'east':
        return 'east';
        break;
      case 'se':
      case 'southeast':
        return 'southeast';
        break;
      case 'ne':
      case 'northeast':
        return 'northeast';
        break;
      case 'sw':
      case 'southwest':
        return 'southwest';
        break;
      case 'nw':
      case 'northwest':
        return 'northwest';
        break;
      case 'u':
      case 'up':
        return 'up';
        break;
      case 'd':
      case 'down':
        return 'down';
        break;

      default:
        return _direction;
    }
  }
}

final Map<String,String> _directionMap = {
  'n' : 'north',
  'north': 'north',
  'nw': 'northwest',
  'northwest': 'northwest',
  'w' : 'west',
  'west' : 'west',
  'sw' : 'southwest',
  'southwest': 'southwest',
  's': 'south',
  'south': 'south',
  'se': 'southeast',
  'southeast': 'southeast',
  'e': 'east',
  'east' : 'east',
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
  String _direction;
  Location _nextloc;
  Map<String, bool> _condition;

  CondExit(this._direction, this._nextloc, this._condition);

  Map<String, bool> get condition => _condition;

  Location get nextloc => _nextloc;

  String get direction => _direction;
}

class UnCondExit {
  String _direction;
  Location _nextloc;

  UnCondExit(this._direction, this._nextloc);

  Location get nextloc => _nextloc;

  String get direction => _direction;
}

class NoExit {
  Direction _direction;
  List<String> _noexittext;

  NoExit(this._direction, this._noexittext);
}
