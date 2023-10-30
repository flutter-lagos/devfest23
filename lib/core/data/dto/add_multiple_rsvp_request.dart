import 'package:equatable/equatable.dart';

final class AddMultipleRSVPRequestDto extends Equatable {
  final List<String> sessionIds;

  const AddMultipleRSVPRequestDto({required this.sessionIds});

  Map<String, dynamic> toJson() => {'sessionIds': sessionIds};

  @override
  List<Object?> get props => [sessionIds];
}
