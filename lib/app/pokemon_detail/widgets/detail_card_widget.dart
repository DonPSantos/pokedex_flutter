import 'package:flutter/material.dart';

class DetailCardWidget extends StatelessWidget {
  final String title;
  final List<String> propsList;
  const DetailCardWidget(
      {super.key, required this.title, required this.propsList});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 150,
        constraints: const BoxConstraints(minHeight: 150),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            Flexible(
              flex: 8,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceAround,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                runSpacing: 5,
                children: [
                  for (var prop in propsList)
                    Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(100, 100, 100, 0.5)),
                      child: Text(
                        prop,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
