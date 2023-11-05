import 'package:equatable/equatable.dart';

import '../../constants.dart';

final class SessionsResponseDto extends Equatable {
  final List<Session> sessions;

  const SessionsResponseDto({required this.sessions});

  factory SessionsResponseDto.fromJson(dynamic json) => switch (json) {
        final List list? => SessionsResponseDto(
            sessions: list
                .map((e) => Session.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        _ => const SessionsResponseDto(sessions: []),
      };

  @override
  List<Object?> get props => [sessions];
}

final class Session extends Equatable {
  final String owner;
  final String level;
  final String scheduledDuration;
  final String description;
  final String hall;
  final String sessionId;
  final String title;
  final String category;
  final String scheduledAt;
  final String sessionFormat;
  final String ownerEmail;
  final String speakerImage;
  final String tagLine;
  final int availableSeats;
  final int slot;
  final DateTime sessionDate;
  final bool hasRsvped;

  const Session({
    required this.owner,
    required this.level,
    required this.scheduledDuration,
    required this.description,
    required this.hall,
    required this.sessionId,
    required this.title,
    required this.category,
    required this.scheduledAt,
    required this.sessionFormat,
    required this.ownerEmail,
    required this.speakerImage,
    required this.tagLine,
    required this.availableSeats,
    required this.slot,
    required this.sessionDate,
    required this.hasRsvped,
  });

  Session.empty()
      : this(
          owner: '',
          level: '',
          scheduledDuration: '',
          description: '',
          hall: '',
          sessionId: '',
          title: '',
          category: '',
          scheduledAt: '',
          sessionFormat: '',
          ownerEmail: '',
          speakerImage: '',
          tagLine: '',
          availableSeats: 0,
          slot: 0,
          sessionDate: DateTime.now(),
          hasRsvped: false,
        );

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        owner: json['owner'] ?? '',
        level: json['level'] ?? '',
        scheduledDuration: json['scheduledDuration'] ?? '',
        description: json['description'] ?? '',
        hall: json['hall'] ?? '',
        sessionId: json['sessionId'] ?? '',
        title: json['title'] ?? '',
        category: json['category'] ?? '',
        scheduledAt: json['scheduledAt'] ?? '',
        sessionFormat: json['sessionFormat'] ?? '',
        ownerEmail: json['ownerEmail'] ?? '',
        speakerImage: json['speakerImage'] ?? '',
        tagLine: json['tagLine'] ?? '',
        availableSeats: json['availableSeats'] ?? 0,
        slot: json['slot'] ?? 0,
        sessionDate: () {
          final date =
              DateTime.tryParse(json['sessionDate'] as String? ?? '') ??
                  Constants.day1;

          return DateTime(date.year, date.month, date.day);
        }(),
        hasRsvped: false,
      );

  Session copyWith({
    String? owner,
    String? level,
    String? scheduledDuration,
    String? description,
    String? hall,
    String? sessionId,
    String? title,
    String? category,
    String? scheduledAt,
    String? sessionFormat,
    String? ownerEmail,
    String? speakerImage,
    String? tagLine,
    int? availableSeats,
    int? slot,
    DateTime? sessionDate,
    bool? hasRsvped,
  }) {
    return Session(
      owner: owner ?? this.owner,
      level: level ?? this.level,
      scheduledDuration: scheduledDuration ?? this.scheduledDuration,
      description: description ?? this.description,
      hall: hall ?? this.hall,
      sessionId: sessionId ?? this.sessionId,
      title: title ?? this.title,
      category: category ?? this.category,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      sessionFormat: sessionFormat ?? this.sessionFormat,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      speakerImage: speakerImage ?? this.speakerImage,
      tagLine: tagLine ?? this.tagLine,
      availableSeats: availableSeats ?? this.availableSeats,
      slot: slot ?? this.slot,
      sessionDate: sessionDate ?? this.sessionDate,
      hasRsvped: hasRsvped ?? this.hasRsvped,
    );
  }

  @override
  List<Object?> get props => [
        owner,
        level,
        scheduledDuration,
        description,
        hall,
        sessionId,
        title,
        category,
        scheduledAt,
        sessionFormat,
        ownerEmail,
        speakerImage,
        tagLine,
        availableSeats,
        slot,
        sessionDate,
        hasRsvped,
      ];
}
