import 'dart:io';

// Shape class with an abstract method
abstract class Shape {
  double area(); // Abstract method
}

// Circle class inheriting from Shape
class Circle extends Shape {
  double radius;

  Circle(this.radius);

  @override
  double area() {
    return 3.14159 * radius * radius;
  }
}

// Rectangle class inheriting from Shape and implementing FileInitializer interface
class Rectangle extends Shape implements FileInitializer {
  double width;
  double height;

  Rectangle(this.width, this.height);

  @override
  double area() {
    return width * height;
  }

  @override
  void initializeFromFile(String filename) {
    try {
      File file = File(filename);
      List<String> lines = file.readAsLinesSync();
      if (lines.length >= 2) {
        width = double.parse(lines[0]);
        height = double.parse(lines[1]);
      }
    } catch (e) {
      print('Error reading file: $e');
    }
  }
}

// Interface for classes that can be initialized from a file
abstract class FileInitializer {
  void initializeFromFile(String filename);
}

void main() {
  // Create a Circle object
  Circle circle = Circle(5);
  print('Area of Circle with radius 5: ${circle.area()}');

  // Create a Rectangle object and initialize from a file
  Rectangle rectangle = Rectangle(0, 0); // Initialize with default values
  rectangle.initializeFromFile('rectangle_data.txt');
  print('Area of Rectangle with width ${rectangle.width} and height ${rectangle.height}: ${rectangle.area()}');

  // Loop to demonstrate area calculation
  List<Shape> shapes = [circle, rectangle];
  for (var shape in shapes) {
    print('Area: ${shape.area()}');
  }
}
