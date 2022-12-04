import 'dart:io';

void main() async {
  String file = await File('day_4/large_input.txt').readAsString();
  solve(file);
}

void solve(String file) {
  final List<String> list = file.split('\n');
  int result1 = 0;
  int result2 = 0;
  for (final String line in list) {
    final List<String> elfs = line.split(',');
    final List<String> firstElfValues = elfs.first.split('-');
    final List<String> secondElfValues = elfs.last.split('-');
    final int firstElfFrom = int.parse(firstElfValues.first);
    final int firstElfTo = int.parse(firstElfValues.last);
    final int secondElfFrom = int.parse(secondElfValues.first);
    final int secondElfTo = int.parse(secondElfValues.last);
    if ((firstElfFrom <= secondElfFrom && firstElfTo >= secondElfTo) ||
        (firstElfFrom >= secondElfFrom && firstElfTo <= secondElfTo)) {
      result1++;
    }
    if (firstElfFrom == secondElfFrom ||
        firstElfTo == secondElfTo ||
        (secondElfFrom >= firstElfFrom && secondElfFrom <= firstElfTo) ||
        (secondElfTo >= firstElfFrom && secondElfFrom <= firstElfTo)) {
      result2++;
    }
  }
  print('Part 1: $result1');
  print('Part 2: $result2');
}
