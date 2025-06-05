import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget(this._controller, {super.key});

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.description, size: 16),
            SizedBox(width: 8),
            Text(
              'Description',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        SizedBox(height: 8),
        TextField(
          minLines: 3,
          maxLines: 10,
          maxLength: 1000,
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'How was it?',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
