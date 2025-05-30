import 'package:flutter/material.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/presentation/pages/trip/detail/w_history_item.dart';

class HistoriesFragment extends StatelessWidget {
  const HistoriesFragment(this._histories, {super.key});

  final List<HistoryEntity> _histories;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Histories',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (_histories.isNotEmpty)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: _histories.length,
              itemBuilder: (context, index) {
                return HistoryItemWidget(_histories[index]);
              },
              separatorBuilder: (_, __) => Divider(),
            ),
          ),
        ),
      ],
    );
  }
}
