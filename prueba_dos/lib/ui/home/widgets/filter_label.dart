import 'package:flutter/cupertino.dart';

import '../../components/label/label.dart';

class LabelFilter extends StatelessWidget {
  const LabelFilter({
    Key? key,
    required this.labels,
  }) : super(key: key);

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: SizedBox(
        height: 32,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            for (var item in labels)
              Row(children: [
                Label(
                  text: item,
                  initialIsSelected: "Snacks" == item,
                ),
                const SizedBox(
                  width: 8,
                )
              ])
          ],
        ),
      ),
    );
  }
}
