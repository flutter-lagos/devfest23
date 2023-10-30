import 'package:equatable/equatable.dart';

final class SpeakersResponseDto extends Equatable {
  final List<Speaker> speakers;

  const SpeakersResponseDto({required this.speakers});

  factory SpeakersResponseDto.fromJson(dynamic json) => switch (json) {
        final List list? => SpeakersResponseDto(
            speakers: list
                .map((e) => Speaker.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        _ => const SpeakersResponseDto(speakers: []),
      };

  @override
  List<Object?> get props => [speakers];
}

final class Speaker extends Equatable {
  final String twitter;
  final String github;
  final String role;
  final String organization;
  final String name;
  final String bio;
  final String linkedIn;
  final String avatar;
  final String email;
  final int order;
  final String category;
  final String currentSession;
  final String currentSessionId;

  const Speaker({
    required this.twitter,
    required this.github,
    required this.role,
    required this.organization,
    required this.name,
    required this.bio,
    required this.linkedIn,
    required this.avatar,
    required this.email,
    required this.order,
    required this.category,
    required this.currentSession,
    required this.currentSessionId,
  });

  const Speaker.empty()
      : this(
          twitter: '',
          github: '',
          role: '',
          organization: '',
          name: '',
          bio: '',
          linkedIn: '',
          avatar: '',
          email: '',
          order: 0,
          category: '',
          currentSession: '',
          currentSessionId: '',
        );

  factory Speaker.fromJson(Map<String, dynamic> json) => Speaker(
        twitter: json['twitter'] ?? '',
        github: json['github'] ?? '',
        role: json['role'] ?? '',
        organization: json['organization'] ?? '',
        name: json['name'] ?? '',
        bio: json['bio'] ?? '',
        linkedIn: json['linkedIn'] ?? '',
        avatar: json['avatar'] ?? '',
        email: json['email'] ?? '',
        order: json['order'] ?? 0,
        category: json['category'] ?? '',
        currentSession: json['currentSession'] ?? '',
        currentSessionId: json['currentSessionId'] ?? '',
      );

  @override
  List<Object?> get props => [
        twitter,
        github,
        role,
        organization,
        name,
        bio,
        linkedIn,
        avatar,
        email,
        order,
        category,
        currentSession,
        currentSessionId,
      ];
}
