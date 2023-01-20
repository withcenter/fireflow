/// Returns a string that represents the order of the comment tree.
///
/// [order] is the parent's comment order. If it has no parent comment, it should null or empty string.
/// [depth] is the depth of the parent comment. If it has no parent comment, it should be null or 0.
/// [noOfComments] is the number of comments of the post.
///
/// Save the return value to the comment's order field.
String commentOrder(
  String? order,
  int? depth,
  int? noOfComments,
) {
  /// 코멘트 트리 구조를 표현하기 위한 정렬 문자열 생성
  ///
  /// 참고, `맨 처음 코멘트`란, 글에 최초로 작성되는 첫 번째 코멘트. 맨 처음 코멘트는 1개만 존재한다.
  /// 참고, `첫번째 레벨 코멘트`란, 글 바로 아래에 작성되는 코멘트로, 부모 코멘트가 없는 코멘트이다. 여러개의 코멘트가 있다.
  /// 참고, `부모 코멘트`란, 자식 코멘트가 있는 코멘트 또는 자식을 만들 코멘트.
  /// 참고, `자식 코멘트`란, 부모 코멘트 아래에 작성되는 코멘트 또는 부모 코멘트가 있는 코멘트.
  ///
  /// [order] 는
  ///   - `첫 번째 레벨 코멘트(부모가 없는 코멘트)` 에는 빈 문자열 또는 null,
  ///   - `자식 코멘트`를 생성 할 때, 부모 코멘트의 order 값을 그대로 전달하면 된다.
  ///
  /// [depth] 는
  ///   - `첫 번째 레벨 코멘트(부모가 없는 코멘트)`에서는 0(또는 null),
  ///   - `자식 코멘트(부모가 있는 코멘트)`의 경우, 부모 코멘트의 depth + 1 값을 전달하면 된다.
  ///
  /// [noOfComment] 는 항상 **글의 noOfComments 값**을 전달하면 된다.
  ///   원래는 코멘트마다 noOfComment 값을 가지고 있고, 이 함수에서 글 또는 부모 코멘트의 noOfComments 를 받아서,
  ///   처리를 했는데, 이 함수가 문제가 아니라, 부모 코멘트마다 noOfComments 를 유지하는 것이, 플러터플로의 복잡도를 높이는
  ///   것이되어, 그냥 글의 noOfComments 를 사용하도록 변경했다.
  ///
  ///
  /// 참고, 이 함수는 depth 의 값을 0(또는 null)으로 입력 받지만, 실제 코멘트 DB(문서)에 저장하는 값은 1부터 시작하는 것을
  ///   원칙으로 한다. 예를 들면, depth 값을 1 증가 시키기 위해서, +1 증가시키는 함수(IncreaseInteger)를 써야 하는데,
  ///   첫번째 레벨의 경우(부모 코멘트가 없는 경우), IncreaseInteger 함수에 0(NULL)을 지정하면 +1을 해서, 1 값이 리턴된다.
  ///   그 값을 코멘트 DB(문서)의 depth 에 저장하므로, 자연스럽게 1 부터 시작하는 것이다.
  ///   또는 첫번째 레벨의 코멘트는 그냥 depth=1 로 지정하면 된다.
  ///   그리고 DB(문서)의 depth 는 사실, 0으로 시작하든 1로 시작하던, UI 랜더링 할 때, depth 만 잘 표현하면 된다.
  ///
  /// 참고, [depth] 가 16 단계 이상으로 깊어지면, 16 단계 이상의 코멘트는 순서가 뒤죽 박죽이 될 수 있다.
  ///   이 때, 전체가 다 뒤죽 박죽이 되는 것이 아니라, 16단계 이내에서는 잘 정렬되어 보이고, 17단계 이상의 코멘트 들만
  ///   정렬이 안되, 17단계, 18단계, 19단계... 등 모두 16단계 부모의 [order] 를 가지므로 16단계 (들여쓰기)아래애서만
  ///   어떤 것이 먼저 쓰였는지 구분하기 어렵게 된다.
  ///
  /// 참고, 총 90만개의 코멘트를 지원한다.
  order = order == null || order == ''
      ? List<String>.filled(16, '100000').join(".")
      : order;
  depth ??= 0;
  noOfComments ??= 0;
  if (depth >= 16) return order;

  // print("order(in): $order, depth: $depth");
  if (noOfComments == 0) {
    return order;
  } else {
    List<String> parts = order.split('.');
    String no = parts[depth];
    // print('no=$no, depth=$depth, parts=$parts');
    int computed = int.parse(no) + noOfComments;
    // print("computed: $computed, depth: $depth");
    parts[depth] = computed.toString();
    order = parts.join('.');

    // print("order(out): $order");
    return order;
  }
}
