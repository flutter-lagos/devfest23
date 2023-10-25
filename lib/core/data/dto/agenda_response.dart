import 'package:equatable/equatable.dart';

final class AgendaResponseDto extends Equatable {
  final List<Agenda> agendas;

  const AgendaResponseDto({required this.agendas});

  factory AgendaResponseDto.fromJson(dynamic json) => switch (json) {
        final List list? => AgendaResponseDto(
            agendas: list
                .map((e) => Agenda.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        _ => const AgendaResponseDto(agendas: []),
      };

  @override
  List<Object?> get props => [agendas];
}

final class Agenda extends Equatable {
  final bool isBreakout;
  final String schedule;
  final int order;
  final String facilitator;
  final String duration;
  final String time;
  final List<AgendaSession> sessions;

  const Agenda({
    required this.isBreakout,
    required this.schedule,
    required this.order,
    required this.facilitator,
    required this.duration,
    required this.time,
    required this.sessions,
  });

  const Agenda.empty()
      : this(
          isBreakout: false,
          schedule: '',
          order: -1,
          facilitator: '',
          duration: '',
          time: '',
          sessions: const [],
        );

  factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
        isBreakout: json['isBreakout'] ?? '',
        schedule: json['schedule'] ?? '',
        order: json['order'] ?? -1,
        facilitator: json['facilitator'] ?? '',
        duration: json['duration'] ?? '',
        time: json['time'] ?? '',
        sessions: switch (json['sessions']) {
          final List list? => list
              .map((e) => AgendaSession.fromJson(e as Map<String, dynamic>))
              .toList(),
          _ => const [],
        },
      );

  @override
  List<Object?> get props => [
        isBreakout,
        schedule,
        order,
        facilitator,
        duration,
        time,
      ];
}

final class AgendaSession extends Equatable {
  final String schedule;
  final String venue;
  final String time;
  final String facilitator;

  const AgendaSession({
    required this.schedule,
    required this.venue,
    required this.time,
    required this.facilitator,
  });

  factory AgendaSession.fromJson(Map<String, dynamic> json) => AgendaSession(
        schedule: json['schedule'] ?? '',
        venue: json['venue'] ?? '',
        time: json['time'] ?? '',
        facilitator: json['facilitator'] ?? '',
      );

  @override
  List<Object?> get props => [schedule, venue, time, facilitator];
}
