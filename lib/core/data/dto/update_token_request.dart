import 'package:equatable/equatable.dart';

final class UpdateTokenRequestDto extends Equatable {
  final String deviceToken;

  const UpdateTokenRequestDto({required this.deviceToken});

  Map<String, dynamic> toJson() => {
        'deviceToken': deviceToken,
      };

  @override
  List<Object?> get props => [deviceToken];
}
