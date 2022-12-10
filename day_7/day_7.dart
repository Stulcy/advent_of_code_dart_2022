import 'dart:io';

void main() async {
  String file = await File('day_7/large_input.txt').readAsString();
  solve(file);
}

void solve(String file) {
  final List<String> list = file.split('\n');
  Node currNode = Node(null, {});
  Map<int, List<Node>> directories = {
    0: [currNode]
  };
  int layer = 1;
  list.forEach(
    (line) {
      if (!(line == '\$ cd /')) {
        if (line == '\$ cd ..') {
          currNode = currNode.parent!;
          layer--;
        } else if (line.contains('dir')) {
          final String name = line.split(' ').last;
          final Node node = Node(currNode, {}, name: name);
          currNode.children[name] = node;
          directories[layer] == null
              ? directories[layer] = [node]
              : directories[layer]!.add(node);
        } else if (line.contains('\$ cd') && !line.contains('..')) {
          layer++;
          final String name = line.split(' ').last;
          currNode = currNode.children[name]!;
        } else if (!line.contains('\$')) {
          currNode.size += int.parse(line.split(' ').first);
        }
      }
    },
  );
  int sumBelow100k = 0;
  for (int i = directories.length - 1; i >= 0; i--) {
    directories[i]!.forEach((dir) {
      dir.calculateSize();
    });
  }
  final int spaceNeeded = 30000000 - (70000000 - directories[0]!.first.size);
  int currMin = 30000000;
  for (int i = directories.length - 1; i >= 0; i--) {
    directories[i]!.forEach((dir) {
      if (dir.size < 100000) sumBelow100k += dir.size;
      if (dir.size > spaceNeeded && dir.size < currMin) currMin = dir.size;
    });
  }
  print('Part 1: $sumBelow100k');
  print('Part 2: $currMin');
}

class Node {
  Node(this.parent, this.children, {this.name = 'root'});

  String name;
  int size = 0;
  Node? parent;
  Map<String, Node> children;

  int calculateSize() {
    children.entries.forEach((child) => size += child.value.size);
    return size;
  }
}
