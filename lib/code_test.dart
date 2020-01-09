void main() {
  var student = Student(5, 100, 30);
  print(student);
}

class Student {
  int _age;
  int _height;
  int _weight;

  Student(this._age, this._height, this._weight);

  int get age => _age;

  int get height => _height;

  int get weight => _weight;

  set weight(int value) {
    _weight = value;
  }

  set height(int value) {
    _height = value;
  }

  set age(int value) {
    _age = value;
  }

  void upAge() => _age++;

  @override
  String toString() {
    return 'Student{_age: $_age, _height: $_height, _weight: $_weight}';
  }
}
