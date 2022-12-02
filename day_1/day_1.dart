import 'dart:io';

void main() async {
  String file = await File('day_1/large_input.txt').readAsString();
  solve(file);
}

void solve(String file) {
  final List<String> list = file.split('\n');
  int tmp = 0;
  List<int> elves = [];
  for (String line in list) {
    if (line.isEmpty) {
      elves.add(tmp);
      tmp = 0;
    } else {
      tmp += int.parse(line);
    }
  }
  elves.sort((a, b) => b.compareTo(a));
  print('Part 1: ${elves.first}');
  print('Part 2: ${elves.take(3).fold<int>(0, (a, b) => a + b)}');
}
