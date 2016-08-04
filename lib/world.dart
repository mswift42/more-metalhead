// world.dart - class representation of rooms, items and the player.

class Location {
  String name;
  List<String> _shortDescription;
  List<String> _longDescription;
  List<CondExit> _cexits;


}

class CondExit {
  String _direction;
  Location _nextloc;
  Map<String,bool> _condition;

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
