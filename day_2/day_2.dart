import 'dart:io';

final Map<String, Map<String, List<int>>> table = {
  'X': {
    'A': [4, 3],
    'B': [1, 1],
    'C': [7, 2],
  },
  'Y': {
    'A': [8, 4],
    'B': [5, 5],
    'C': [2, 6],
  },
  'Z': {
    'A': [3, 8],
    'B': [9, 9],
    'C': [6, 7],
  },
};

void main() async {
  String file = await File('day_2/large_input.txt').readAsString();
  solve(file);
}

void solve(String file) {
  final List<String> list = file.split('\n');
  int result1 = 0;
  int result2 = 0;
  for (String line in list) {
    List<String> game = line.split(' ');
    final String me = game.last;
    final String him = game.first;
    result1 += table[me]![him]!.first;
    result2 += table[me]![him]!.last;
  }
  print('Part 1: $result1');
  print('Part 2: $result2');
}
