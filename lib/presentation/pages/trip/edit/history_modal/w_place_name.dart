import 'package:flutter/material.dart';

class PlaceNameWidget extends StatelessWidget {
  const PlaceNameWidget(this._controller, {super.key});

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_city_outlined, size: 16),
            SizedBox(width: 8),
            Text(
              'Place Name',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        SizedBox(height: 8),
        TextField(
          minLines: 1,
          maxLines: 1,
          maxLength: 30,
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Where did you go?',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
