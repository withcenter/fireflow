/// Chunk array into smaller arrays of a specified size.
///
/// [list] is the array to chunk.
///
/// [chunkSize] is the size of each chunk.
///
/// [fill] is the value to fill the last chunk if it is smaller than [chunkSize].
///
/// example)
///   chunk([1, 2, 3, 4], 3, fill: 0)
/// result)
///   [[1, 2, 3], [4, 0, 0]]
///
/// example)
///   chunk(['a', 'b', 'c'], 2, fill: ''])
/// result)
///   [['a', 'b'], ['c', '']]
///
List<List<T>> chunkArray<T>(List<T> list, int chunkSize, {T? fill}) {
  List<List<T>> chunks = [];
  int len = list.length;
  for (var i = 0; i < len; i += chunkSize) {
    int size = i + chunkSize;
    chunks.add(list.sublist(i, size > len ? len : size));
  }
  int n = chunks.last.length;
  if (fill != null && n < chunkSize) {
    chunks.last.addAll(List<T>.filled(chunkSize - n, fill));
  }
  return chunks;
}
