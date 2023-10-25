import 'package:equatable/equatable.dart';

final class AddToRSVPRequestDto extends Equatable {
  final String sessionId;

  const AddToRSVPRequestDto({required this.sessionId});

  Map<String, dynamic> toJson() => {'sessionId': sessionId};

  @override
  List<Object?> get props => [sessionId];
}
