import 'dart:io';

void main() async {
  String file = await File('day_5/large_input.txt').readAsString();
  solve(file);
}

void solve(String file) {
  final List<String> list = file.split('\n');
  int lineWithNums = 0;
  while (list[lineWithNums].isNotEmpty) lineWithNums++;
  final int numOfCrates = [
    for (final strNum in list[lineWithNums - 1].split(''))
      if (int.tryParse(strNum) != null) int.parse(strNum)
  ].fold<int>(0, (a, b) => (b > a) ? b : a);
  final Map<int, List<String>> stacks1 = {};
  final Map<int, List<String>> stacks2 = {};
  for (int i = numOfCrates; i > 0; i--) {
    for (int j = lineWithNums - 2; j >= 0; j--) {
      String char = list[j][1 + (i - 1) * 4];
      if (char != ' ') {
        stacks1[i] != null ? stacks1[i]?.add(char) : stacks1[i] = [char];
        stacks2[i] != null ? stacks2[i]?.add(char) : stacks2[i] = [char];
      }
    }
  }
  for (final String line in list.skip(lineWithNums + 1)) {
    final List<String> splitted = line.split(' ');
    final int howMuch = int.parse(splitted[1]);
    final int from = int.parse(splitted[3]);
    final int to = int.parse(splitted.last);
    List<String> tmpList = [];
    for (int i = 0; i < howMuch; i++) {
      stacks1[to] != null
          ? stacks1[to]!.add(stacks1[from]!.removeLast())
          : stacks1[to] = [stacks1[from]!.removeLast()];
      tmpList.add(stacks2[from]!.removeLast());
    }
    stacks2[to] != null
        ? stacks2[to]!.addAll(tmpList.reversed.toList())
        : stacks2[to] = tmpList.reversed.toList();
    tmpList.clear();
  }
  String result1 = '';
  String result2 = '';
  for (int i = 1; i <= numOfCrates; i++) {
    result1 += stacks1[i]!.last;
    result2 += stacks2[i]!.last;
  }
  print('Part 1: $result1');
  print('Part 2: $result2');
}
