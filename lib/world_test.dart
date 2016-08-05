import 'package:test/test.dart';
import 'package:more_metalhead/world.dart';


void main() {
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
  });
}