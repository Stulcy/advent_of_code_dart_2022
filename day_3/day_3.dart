import 'dart:io';

void main() async {
  String file = await File('day_3/large_input.txt').readAsString();
  solve(file);
}

void solve(String file) {
  final List<String> list = file.split('\n');
  Set<String> firstHalfChars;
  Set<String> secondHalfChars;
  int result1 = 0;
  int result2 = 0;
  List<Set<String>> elfGroup = <Set<String>>[];
  for (final String line in list) {
    final List<String> lineList = line.split('');
    firstHalfChars = lineList.take((line.length / 2).round()).toSet();
    secondHalfChars = lineList.reversed
        .take((line.length / 2).round())
        .toList()
        .reversed
        .toSet();
    final String common = firstHalfChars.intersection(secondHalfChars).first;
    result1 += (common.toUpperCase() == common)
        ? common.codeUnits.first - 38
        : common.codeUnits.first - 96;
    elfGroup.add(lineList.toSet());
    if (elfGroup.length == 3) {
      final String common =
          elfGroup[0].intersection(elfGroup[1]).intersection(elfGroup[2]).first;
      elfGroup.clear();
      result2 += (common.toUpperCase() == common)
          ? common.codeUnits.first - 38
          : common.codeUnits.first - 96;
    }
  }
  print('Part 1: $result1');
  print('Part 2: $result2');
}
