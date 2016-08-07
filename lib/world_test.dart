import 'package:test/test.dart';
import 'package:more_metalhead/world.dart';

void main() {
  var incmd1 = new InputCmd("open door");
  var outcmd1 = new ExecCmd("openBathroomDoor");
  var item1 = new Item("laptop", ["laptop", "notebook", "computer"],
      ["this is your laptop"], ["this is your trusted Thinkpad"], ["your laptop"],
      {incmd1: outcmd1}, {"visited" : false, "poweredOn": false});
  test("The class direction getter returns a downcased direction", () {
    var d1 = new Direction('WEST');
    expect(d1.direction, "west");
    var d2 = new Direction('South');
    expect(d2.direction, "south");
    var d3 = new Direction("nORth");
    expect(d3.direction, "north");
    var d4 = new Direction("east");
    expect(d4.direction, "east");
    var d5 = new Direction("southWEST");
    expect(d5.direction, "southwest");
    var d6 = new Direction("UP");
    expect(d6.direction, 'up');
  });
  test("The direction getter returns the full name for abbreviated inputs", () {
    var d1 = new Direction('ne');
    expect(d1.direction, "northeast");
    var d2 = new Direction('e');
    expect(d2.direction, 'east');
    var d3 = new Direction('S');
    expect(d3.direction, "south");
    var d4 = new Direction('NW');
    expect(d4.direction, "northwest");
    var d5 = new Direction('sE');
    expect(d5.direction, "southeast");
    var d6 = new Direction('d');
    expect(d6.direction, 'down');
    var d7 = new Direction('u');
    expect(d7.direction, 'up');
  });
  test("the Location class get's initialized correctly", () {
    var dir1 = new Direction("e");
    var ne1 = new NoExit(["nothing here"]);
    var it1 = new Item("soap", ["soap", "washing soap", "soap brick"],
        ["soap"], ["long soap"], ["short soap"], {}, {});
    var d1 = new Location("bathroom", [
      "this is the long bathroom"
    ], [
      "this is the short bathroom"
    ], {
      dir1: ne1
    }, {"visited" : false}, [it1]);
    expect(d1.name, "bathroom");
    expect(d1.longDescription[0], "this is the long bathroom");
    expect(d1.shortDescription[0], "this is the short bathroom");
    expect(d1.exits[dir1].noexittext, ["nothing here"]);
    expect(d1.items[0].name, "soap");
  });
  test("the command class getter should return the commandname", () {
    expect(new Command("press button").command, "press button");
    expect(new InputCmd("look at button").command, "look at button");
    expect(new ExecCmd("pressButton").command, "pressButton");
  });
  test ("the Item class get's initialized correctly", () {
    expect(item1.firstDescription[0], "this is your laptop");
    expect(item1.name, "laptop");
    expect(item1.synonyms.contains("computer"), true);
    expect(item1.flags["visited"], false);
    expect(item1.actions[incmd1], outcmd1);
    expect(item1.actions.containsKey(incmd1), true);
    expect(item1.actions[incmd1].command, "openBathroomDoor");
  });
}
