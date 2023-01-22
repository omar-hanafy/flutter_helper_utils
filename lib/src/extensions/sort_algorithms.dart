extension SearchAlgorithmExtensions on List<int> {
  List<int> quickSort([int? left, int? right]) {
    final list = this;
    if ((left ?? 0) >= (right ?? 0)) return [-1];
    var pivot = left!, i = left, j = right!, direction = -1, temp = 0;
    while (i < j) {
      if (direction == -1) {
        if (list[j] < list[pivot]) {
          temp = list[j];
          list[j] = list[pivot];
          list[pivot] = temp;
          pivot = j;
          direction = 1;
        } else {
          j--;
        }
      }
      if (direction == 1) {
        if (list[i] > list[pivot]) {
          temp = list[i];
          list[i] = list[pivot];
          list[pivot] = temp;
          pivot = i;
          direction = -1;
        } else {
          i++;
        }
      }
    }
    quickSort(left, i);
    quickSort(i + 1, right);

    return list;
  }
}
