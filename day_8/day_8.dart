import 'dart:io';

void main() async {
  String file = await File('day_8/large_input.txt').readAsString();
  solve(file);
}

void solve(String file) {
  final List<String> list = file.split('\n');
  final int size = list[0].length;
  List<List<int>> grid = [for (var i = 0; i < size; i++) []];
  for (final int x in [for (var i = 0; i < size; i++) i])
    list[x].split('').forEach((char) {
      grid[x].add(int.parse(char));
    });
  int count = size * 4 - 4;
  int maxScenicScore = 0;
  for (final int x in [for (var i = 1; i < size - 1; i++) i]) {
    for (final int y in [for (var i = 1; i < size - 1; i++) i]) {
      int scenicScore = 0;
      int left = 0, right = 0, up = 0, down = 0;
      final List<int> sublistUp = [];
      for (final int i in [for (var i = 0; i < x; i++) i])
        sublistUp.add(grid[i][y]);
      final List<int> sublistDown = [];
      for (final int i in [for (var i = x + 1; i < size; i++) i])
        sublistDown.add(grid[i][y]);
      for (final int tree in grid[x].take(y).toList().reversed) {
        left++;
        if (tree >= grid[x][y]) break;
      }
      for (final int tree in grid[x].skip(y + 1)) {
        right++;
        if (tree >= grid[x][y]) break;
      }
      for (final int tree in sublistUp.reversed) {
        up++;
        if (tree >= grid[x][y]) break;
      }
      for (final int tree in sublistDown) {
        down++;
        if (tree >= grid[x][y]) break;
      }
      scenicScore = left * right * up * down;
      if (scenicScore > maxScenicScore) maxScenicScore = scenicScore;
      if ((grid[x][y] >
              grid[x].take(y).fold<int>(0, (a, b) => a < b ? b : a)) ||
          (grid[x][y] >
              grid[x].skip(y + 1).fold<int>(0, (a, b) => a < b ? b : a)) ||
          (grid[x][y] > sublistUp.fold<int>(0, (a, b) => a < b ? b : a)) ||
          (grid[x][y] > sublistDown.fold<int>(0, (a, b) => a < b ? b : a))) {
        count++;
        continue;
      }
    }
  }

  print('Part 1: $count');
  print('Part 2: $maxScenicScore');
}
