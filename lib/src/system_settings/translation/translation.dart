import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';

class Translation extends StatefulWidget {
  const Translation({Key? key, required this.languages}) : super(key: key);
  final List<String> languages;

  @override
  createState() => _TranslationState();
}

class _TranslationState extends State<Translation> {
  String searchWord = '';

  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    final doc = SystemSettingService.instance.col.doc('translations');

    doc.snapshots().listen((snapshot) {
      if (snapshot.exists == false || snapshot.data() == null) {
        return;
      }

      // sort
      final map = snapshot.data() as Map<String, dynamic>;
      data = Map.fromEntries(
          map.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SearchKeyword(
                    onChange: (word) => setState(() => searchWord = word),
                  ),
                ),
                const SizedBox(width: 32),
                const TransationAdd(),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(),
          for (final code in data.keys)
            TranslationCode(
              key: ValueKey(code),
              code: code,
              languages: widget.languages,
              data: data,
              searchWord: searchWord,
            ),
        ],
      ),
    );
  }
}

class TranslationCode extends StatelessWidget {
  const TranslationCode({
    Key? key,
    required this.code,
    required this.languages,
    required this.data,
    required this.searchWord,
  }) : super(key: key);

  final String code;
  final List<String> languages;
  final Map<String, dynamic> data;
  final String searchWord;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> texts = data[code];

    bool contains = code.toLowerCase().contains(searchWord.toLowerCase());
    if (contains == false) {
      for (final key in texts.keys) {
        final value = texts[key];
        if (value.toString().toLowerCase().contains(searchWord.toLowerCase())) {
          contains = true;
          break;
        }
      }
    }
    if (contains == false) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Text(code,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 10)),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    /// Show confirmation dialog asking if the user is sure they want to delete the item
                    /// If the user confirms, delete the item from the database
                    showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: const Text('Delete Translation'),
                          content: const Text(
                              'Are you sure you want to delete this translation?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                SystemSettingService.instance.col
                                    .doc('translations')
                                    .update({code: FieldValue.delete()});
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      }),
                    );
                  },
                  child: const Text('Delete', style: TextStyle(fontSize: 10))),
            ],
          ),
          for (final ln in languages) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TranslationTextField(texts: texts, ln: ln, code: code),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class TransationAdd extends StatelessWidget {
  const TransationAdd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          builder: ((context) {
            final TextEditingController code = TextEditingController();
            return AlertDialog(
              title: const Text('Add Translation'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'You can add transtion code here. And edit it on the list',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: code,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Code',
                    ),
                    onSubmitted: (value) {
                      TranslationService.instance.add(code.text);
                      Navigator.pop(context);
                    },
                    focusNode: FocusNode(
                        canRequestFocus: true,
                        skipTraversal: false,
                        descendantsAreFocusable: true)
                      ..requestFocus(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    TranslationService.instance.add(code.text);
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          }),
        );
      },
      icon: const Icon(
        Icons.add,
      ),
      label: const Text('Add'),
    );
  }
}

class TranslationTextField extends StatefulWidget {
  const TranslationTextField({
    Key? key,
    required this.texts,
    required this.ln,
    required this.code,
  }) : super(key: key);

  final Map<String, dynamic> texts;
  final String ln;
  final String code;

  @override
  createState() => _TranslationTextFieldState();
}

class _TranslationTextFieldState extends State<TranslationTextField> {
  final TextEditingController text = TextEditingController();

  @override
  void initState() {
    super.initState();
    text.text = widget.texts[widget.ln] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final code = "${widget.code}.${widget.ln}";
    return TextField(
      controller: text,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.ln,
      ),
      onChanged: (value) {
        EasyDebounce.debounce(
          code,
          const Duration(milliseconds: 400),
          () => SystemSettingService.instance.col.doc('translations').update(
            {code: value},
          ),
        );
      },
    );
  }
}

class SearchKeyword extends StatefulWidget {
  const SearchKeyword({Key? key, required this.onChange}) : super(key: key);

  final Function(String) onChange;

  @override
  State<SearchKeyword> createState() => _SearchKeywordState();
}

class _SearchKeywordState extends State<SearchKeyword> {
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('build search: ${search.text}');
    return TextField(
      controller: search,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
        labelText: 'Search',
        isDense: true,
      ),
      onChanged: (uovalue) => widget.onChange(search.text),
    );
  }
}
