import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/presentation/providers/export.dart';
import 'package:vacation/shared/export.dart';

import 'history_modal/s_edit_history_modal.dart';

enum PopUpMenuEnums {
  edit(label: 'EDIT', iconData: Icons.edit_outlined),
  delete(label: "DELETE", iconData: Icons.delete_outline);

  final String label;
  final IconData iconData;

  const PopUpMenuEnums({required this.label, required this.iconData});
}

class HistoriesFragment extends StatefulWidget {
  const HistoriesFragment(this._histories, {super.key});

  final List<HistoryEntity> _histories;

  @override
  State<HistoriesFragment> createState() => _HistoriesFragmentState();
}

class _HistoriesFragmentState extends State<HistoriesFragment>
    with DateFormatterMixIn {
  late Stream<bool> _stream;

  @override
  initState() {
    super.initState();
    _stream =
        context
            .read<EditTripBloc>()
            .stream
            .map((e) => e.status == Status.success)
            .distinct();
  }

  _handleInsertHistory({
    required String placeName,
    required String description,
    required DateTime visitedAt,
    required List<XFile> images,
    double? latitude,
    double? longitude,
  }) {
    context.read<EditTripBloc>().add(
      InsertHistoryDataEvent(
        placeName: placeName,
        description: description,
        images: images,
        visitedAt: visitedAt,
        latitude: latitude,
        longitude: longitude,
      ),
    );
  }

  _handleShowCreateHistoryModal() async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder:
          (_) => EditHistoryModalScreen(
            handleSubmit: _handleInsertHistory,
            dateRange: context.read<EditTripBloc>().state.data.trip.dateRange,
            statusStream: _stream,
          ),
    );
  }

  _handleUpdateHistory(HistoryEntity e) => ({
    required String placeName,
    required String description,
    required DateTime visitedAt,
    required List<XFile> images,
    double? latitude,
    double? longitude,
  }) {
    context.read<EditTripBloc>().add(
      UpdateHistoryDataEvent(
        historyId: e.id,
        placeName: placeName,
        description: description,
        visitedAt: visitedAt,
        images: images,
      ),
    );
  };

  _handleShowEditHistoryModal(HistoryEntity e) => () async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder:
          (_) => EditHistoryModalScreen(
            initialHistory: e,
            handleSubmit: _handleUpdateHistory(e),
            dateRange: context.read<EditTripBloc>().state.data.trip.dateRange,
            statusStream: _stream,
          ),
    );
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Histories',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            IconButton(
              onPressed: _handleShowCreateHistoryModal,
              icon: Icon(Icons.add_circle_outline),
            ),
          ],
        ),
        if (widget._histories.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget._histories.length,
            itemBuilder: (context, index) {
              final history = widget._histories[index];
              return ListTile(
                title: Text(
                  history.placeName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                subtitle: Text(
                  handleFormatDateTime(history.visitedAt),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                trailing: PopupMenuButton<PopUpMenuEnums>(
                  itemBuilder: (context) {
                    return PopUpMenuEnums.values
                        .map(
                          (menu) => PopupMenuItem(
                            value: menu,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(menu.iconData, size: 20),
                                SizedBox(width: 8),
                                Text(menu.label),
                              ],
                            ),
                            onTap: () async {
                              switch (menu) {
                                case PopUpMenuEnums.edit:
                                  await _handleShowEditHistoryModal(
                                    history,
                                  )(); // 수정 모달창 띄우기
                                  return;
                                case PopUpMenuEnums.delete:
                                  context.read<EditTripBloc>().add(
                                    DeleteHistoryEvent(history.id),
                                  ); // 히스토리 삭제
                                  return;
                              }
                            },
                          ),
                        )
                        .toList();
                  },
                  icon: Icon(Icons.more_vert),
                ),
              );
            },
          ),
      ],
    );
  }
}
