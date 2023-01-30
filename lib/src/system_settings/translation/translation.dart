import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/system_settings/system_setting.service.dart';
import 'package:flutter/material.dart';

class Translation extends StatelessWidget {
  const Translation({Key? key, required this.languages}) : super(key: key);
  final List<String> languages;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            SystemSettingService.instance.col.doc('translations').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData ||
              snapshot.data == null ||
              !snapshot.data!.exists) {
            return const Center(child: Text('No data'));
          }
          final Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          print('data; $data');

          final keys = data.keys;

          /// 여기서 부터, ... 글 쓸 때 자동 저장하고,
          /// AppService 에서 자동으로 이 값을 listen 하고, AppService.instance.translations 에 보관한다.
          /// $.name, $.home 과 같이 할 수 있지만, .... 좀 고민을 해야 할 것 같다.
          /// 그래서 그냥 ln('code') 입력 변수 하나만으로 모두 처리 할 수 있도록 한다. (JSON 이게 더 좋을 듯) 둘 다  쓸 수  있도록 한다.
          return ListView.separated(
            itemBuilder: (context, index) {
              final code = keys.elementAt(index);
              final texts = data[code];
              return Container(
                key: ValueKey(code),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index == 0)
                      Container(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Translations',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            TransationAdd(),
                          ],
                        ),
                      ),
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
                                              .update(
                                                  {code: FieldValue.delete()});
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                }),
                              );
                            },
                            child: const Text('Delete',
                                style: TextStyle(fontSize: 10))),
                      ],
                    ),
                    for (final ln in languages) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TranslationTextField(
                                texts: texts, ln: ln, code: code),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            },
            itemCount: keys.length,
            separatorBuilder: (context, index) => const Divider(),
          );
        });
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
      icon: Icon(
        Icons.add,
      ),
      label: Text('Add'),
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
      key: ValueKey(code),
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
