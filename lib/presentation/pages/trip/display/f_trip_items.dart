import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/presentation/providers/export.dart';
import 'package:vacation/shared/export.dart';

import '../../routes/route_config.dart';

enum PopUpMenuEnums {
  edit(label: 'EDIT', iconData: Icons.edit_outlined),
  delete(label: "DELETE", iconData: Icons.delete_outline);

  final String label;
  final IconData iconData;

  const PopUpMenuEnums({required this.label, required this.iconData});
}

class TripItemsFragment extends StatelessWidget with DateFormatterMixIn {
  const TripItemsFragment(this._trips, {super.key});

  final List<TripEntity> _trips;

  @override
  Widget build(BuildContext context) {
    return _trips.isEmpty
        ? SizedBox.shrink()
        : ListView.builder(
          shrinkWrap: true,
          itemCount: _trips.length,
          itemBuilder: (context, index) {
            final trip = _trips[index];
            return ListTile(
              onTap: () async {
                await context.push(
                  RoutePaths.tripDetail.path,
                  extra: trip,
                ); // 상세 페이지 라우팅
              },
              title: Text(
                trip.tripName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Text(
                '${handleFormatDateTime(trip.startDate)}~${handleFormatDateTime(trip.endDate)}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
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
                                await context.push(
                                  RoutePaths.editTrip.path,
                                  extra: trip,
                                ); // 수정 페이지 라우팅
                              case PopUpMenuEnums.delete:
                                context.read<DisplayTripsBloc>().add(
                                  DeleteTripEvent(trip.id),
                                ); // 게시글 삭제
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
        );
  }
}
