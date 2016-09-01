import 'package:test/test.dart';
import 'package:more_metalhead/world.dart';

void main() {
  var direction1 = new Direction('u');
  var direction2 = new Direction('e');
  var direction3 = new Direction('w');
  var location1 = new Location("bathroom", [
    "this is the bathroom"
  ], [
    "your bathroom"
  ], {
    direction1: new NoExit(["no exit there"])
  }, {
    "visited": false
  }, []);
  var condexit1 = new CondExit(
      location1, {"isOpened": true}, ["You can't open the door without a key"]);
  var condexit2 = new CondExit(location1, {"hasKey": false, "isOpened": true},
      ["you need a key stupid"]);
  var incmd1 = new InputCmd("open door");
  var outcmd1 = new ExecCmd("openBathroomDoor");
  var item1 = new Item();
  item1.name = "laptop";
  item1.synonyms = ["laptop", "computer", "netbook", "PC"];
  item1.flags = {"poweredOn": false};
  item1.actions = {incmd1: outcmd1};
  item1.firstDescription = ["this is your laptop"];
  var item2 = new Item();
  item2.name = "wallet";
  var npc1 = new NPC();
  npc1.name = "thomas";
  npc1.firstDescription = ["thomas is sitting on the chair."];
  var location2 = new Location("hallway", ["this is the hallway"],
      ["your hallway"], {direction2: condexit1}, {"visited": false}, []);
  var location3 = new Location(
      "living room",
      ["this is the living room"],
      ["the living room"],
      {direction2: condexit1},
      {"visited": false},
      [item1, item2]);
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
    var it1 = new Item();
    it1.name = "soap";
    var d1 = new Location("bathroom", ["this is the long bathroom"],
        ["this is the short bathroom"], {dir1: ne1}, {"visited": false}, [it1]);
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
  test("the Item class get's initialized correctly", () {
    expect(item1.firstDescription[0], "this is your laptop");
    expect(item1.name, "laptop");
    expect(item1.synonyms.contains("computer"), true);
    expect(item1.flags["poweredOn"], false);
    expect(item1.actions[incmd1], outcmd1);
    expect(item1.actions.containsKey(incmd1), true);
    expect(item1.actions[incmd1].command, "openBathroomDoor");
  });
  test("the Command class get's initialized correctly", () {
    var cm1 = new Command("open door");
    expect(cm1.command, "open door");
  });
  test("the InputCmd class get's initialized correctly", () {
    var inp1 = new InputCmd("open door");
    expect(inp1.command, "open door");
  });
  test("the ExecCmd class get's initialized correctly", () {
    expect(outcmd1.command, "openBathroomDoor");
  });
  test("The Player class get's initialized correctly", () {
    var p1 = new Player();
    p1.location = location1;
    p1.addItem(item1);
    p1.addItem(item2);
    expect(p1.location.name, "bathroom");
    expect(p1.inventory.length, 2);
    p1.dropItem(item1);
    expect(p1.inventory.length, 1);
    expect(p1.inventory[0].name, "wallet");
  });
  test("conditional Exit return false if single condition is not met.", () {
    expect(condexit1.meetsAllConditions(), true);
    expect(condexit2.meetsAllConditions(), false);
  });
  test("player can move to a different location", () {
    var p1 = new Player();
    p1.location = location2;
    expect(p1.location.name, "hallway");
    var exittext = p1.moveInDirection(direction2);
    expect(p1.location.name, "bathroom");
    expect(p1.flagStatus("visitedBathroom"), true);
    expect(exittext, ["this is the bathroom"]);
  });
  test("player can pick up an item", () {
    var p1 = new Player();
    p1.location = location3;
    expect(p1.inventory.length, 0);
    expect(p1.location.items.length, 2);
    p1.addItem(item1);
    expect(p1.inventory.length, 1);
    expect(p1.location.items.length, 1);
  });
  test("player can drop an item", () {
    var p1 = new Player();
    p1.location = location3;
    expect(p1.inventory.length, 0);
    p1.addItem(item2);
    expect(p1.inventory.contains(item2), true);
    expect(p1.location.items.contains(item2), false);
    p1.dropItem(item2);
    expect(p1.inventory.contains(item2), false);
    expect(p1.location.items.contains(item2), true);
  });
  test("visitedFlagName method returns a Camel cased visited + location", () {
    var p1 = new Player();
    p1.location = location3;
    expect(p1.visitedFlagName(p1.location.name), "visitedLivingRoom");
    p1.location = location1;
    expect(p1.visitedFlagName(p1.location.name), "visitedBathroom");
    p1.location = location2;
    expect(p1.visitedFlagName(p1.location.name), "visitedHallway");
  });
}
