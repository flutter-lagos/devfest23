import 'package:equatable/equatable.dart';

final class RSVPSessionRequestDto extends Equatable {
  final String sessionId;

  const RSVPSessionRequestDto({required this.sessionId});

  Map<String, dynamic> toJson() => {'sessionId': sessionId};

  @override
  List<Object?> get props => [sessionId];
}
