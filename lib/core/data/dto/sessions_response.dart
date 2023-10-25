import 'package:equatable/equatable.dart';

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
  });

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
      );

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
      ];
}
