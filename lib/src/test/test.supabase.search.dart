import 'package:fireflow/fireflow.dart';

Future testSupabaseSearch() async {
  final id = randomString();

  await SupabaseService.instance
      .searchInsert(id: id, category: 'cat1', text: 'text 1');
  await SupabaseService.instance.searchDelete(id);
  final row = await SupabaseService.instance.searchGet(id);
  assert(row is List);
  assert(row.isEmpty);

  await SupabaseService.instance
      .searchUpsert(id: id, category: 'cat1', text: 'text 1');
  await SupabaseService.instance
      .searchUpsert(id: id, category: 'cat2', text: 'text 2');

  final updated = await SupabaseService.instance.searchGet(id);
  assert(updated is List);
  assert(updated.length == 1);
}
