import 'package:devfest23/core/constants.dart';
import 'package:devfest23/core/themes/colors.dart';
import 'package:devfest23/core/themes/theme_data.dart';
import 'package:devfest23/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../providers/theme_providers.dart';

@widgetbook.UseCase(name: 'Session Chips', type: DevfestChips)
Widget devfestSessionChip(BuildContext context) {
  return Material(
    color: DevFestTheme.of(context).backgroundColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(child: SessionTimeChip(sessionTime: DateTime.now())),
        const SizedBox(height: Constants.verticalGutter),
        const Align(child: SessionVenueChip(venue: 'Entrance')),
        const SizedBox(height: Constants.verticalGutter),
        const Align(child: SessionSlotsChip(slotsLeft: 100)),
        const SizedBox(height: Constants.verticalGutter),
        const Align(child: SessionSlotsChip(slotsLeft: 3)),
        const SizedBox(height: Constants.verticalGutter),
        const Align(child: SessionSlotsChip(slotsLeft: 0)),
        const SizedBox(height: Constants.verticalGutter),
        const Align(child: SessionStatusChip(isOngoing: true)),
        const SizedBox(height: Constants.verticalGutter),
        const Align(child: SessionStatusChip(isOngoing: false)),
        const SizedBox(height: Constants.verticalGutter),
        const Align(child: SessionTimeLeftChip(minuteLeft: 45)),
      ],
    ),
  );
}

class SessionTimeChip extends StatelessWidget {
  const SessionTimeChip({super.key, required this.sessionTime});

  final DateTime sessionTime;

  static final _timeOfDayFormat = DateFormat.jm();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Constants.smallVerticalGutter / 2,
        horizontal: Constants.horizontalGutter,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: DevfestColors.yellowSecondary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Symbols.alarm,
            weight: Constants.iconWeight,
            color: DevfestColors.grey0,
          ),
          const SizedBox(width: Constants.horizontalGutter),
          Text(
            _timeOfDayFormat.format(sessionTime),
            style: DevFestTheme.of(context).textTheme?.body03?.copyWith(
                fontWeight: FontWeight.w500, color: DevfestColors.grey0),
          ),
        ],
      ),
    );
  }
}

class SessionTimeLeftChip extends StatelessWidget {
  const SessionTimeLeftChip({super.key, required this.minuteLeft});

  final int minuteLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Constants.smallVerticalGutter / 2,
        horizontal: Constants.horizontalGutter,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: DevfestColors.greenSecondary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Symbols.hourglass_empty,
            weight: Constants.iconWeight,
            color: DevfestColors.grey0,
          ),
          const SizedBox(width: Constants.horizontalGutter / 2),
          Text(
            '${minuteLeft}m',
            style: DevFestTheme.of(context).textTheme?.body03?.copyWith(
                fontWeight: FontWeight.w500, color: DevfestColors.grey0),
          ),
        ],
      ),
    );
  }
}

class SessionVenueChip extends StatelessWidget {
  const SessionVenueChip({super.key, required this.venue});

  final String venue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Constants.smallVerticalGutter / 2,
        horizontal: Constants.horizontalGutter,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: DevfestColors.yellowSecondary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Symbols.pin_drop,
            weight: Constants.iconWeight,
            color: DevfestColors.grey0,
          ),
          const SizedBox(width: Constants.horizontalGutter),
          Text(
            venue,
            style: DevFestTheme.of(context).textTheme?.body03?.copyWith(
                fontWeight: FontWeight.w500, color: DevfestColors.grey0),
          ),
        ],
      ),
    );
  }
}

class SessionSlotsChip extends ConsumerWidget {
  const SessionSlotsChip({super.key, required this.slotsLeft});

  final int slotsLeft;

  bool get _isSlotBookingEmergency {
    return slotsLeft <= 5 && slotsLeft > 0;
  }

  @override
  Widget build(BuildContext context, ref) {
    final contentColor = () {
      if (_isSlotBookingEmergency) return DevfestColors.red;

      if (ref.watch(isDarkProvider)) return DevfestColors.grey100;
      return DevfestColors.grey30;
    }();
    final chipColor = () {
      if (_isSlotBookingEmergency) {
        return DevfestColors.redSecondary.withOpacity(0.2);
      }

      if (ref.watch(isDarkProvider)) return DevfestColors.grey30;

      return DevfestColors.grey90;
    }();
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Constants.smallVerticalGutter / 2,
        horizontal: Constants.horizontalGutter,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        color: chipColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Symbols.group,
            weight: Constants.iconWeight,
            color: contentColor,
          ),
          const SizedBox(width: Constants.horizontalGutter / 2),
          Text(
            slotsLeft <= 0
                ? 'No slots left'
                : '$slotsLeft Slot${slotsLeft > 1 ? 's' : ''} Left',
            style: DevFestTheme.of(context)
                .textTheme
                ?.body03
                ?.copyWith(fontWeight: FontWeight.w500, color: contentColor),
          ),
        ],
      ),
    );
  }
}

class SessionStatusChip extends ConsumerWidget {
  const SessionStatusChip({super.key, required this.isOngoing});

  final bool isOngoing;

  @override
  Widget build(BuildContext context, ref) {
    final chipColor = () {
      if (isOngoing) return DevfestColors.greenSecondary.withOpacity(0.2);
      if (ref.watch(isDarkProvider)) return DevfestColors.grey30;
      return DevfestColors.grey90;
    }();
    final contentColor = () {
      if (isOngoing) return DevfestColors.green;
      if (ref.watch(isDarkProvider)) return DevfestColors.grey100;
      return DevfestColors.grey30;
    }();
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Constants.smallVerticalGutter / 2,
        horizontal: Constants.horizontalGutter,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        color: chipColor,
      ),
      child: isOngoing
          ? Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: contentColor),
                ),
                const SizedBox(width: Constants.horizontalGutter / 2),
                Text(
                  'Ongoing',
                  style: DevFestTheme.of(context).textTheme?.body03?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: contentColor,
                      ),
                ),
              ],
            )
          : Text(
              'Completed',
              style: DevFestTheme.of(context)
                  .textTheme
                  ?.body03
                  ?.copyWith(fontWeight: FontWeight.w500, color: contentColor),
            ),
    );
  }
}
