final class UpdateTokenRequestDto {
  final String deviceToken;

  const UpdateTokenRequestDto({required this.deviceToken});

  Map<String, dynamic> toJson() => {
        'deviceToken': deviceToken,
      };
}
