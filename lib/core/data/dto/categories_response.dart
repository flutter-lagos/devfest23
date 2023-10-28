import 'package:equatable/equatable.dart';

final class CategoriesResponseDto extends Equatable {
  final List<Category> categories;

  const CategoriesResponseDto({required this.categories});

  factory CategoriesResponseDto.fromJson(dynamic json) => switch (json) {
        final List list? => CategoriesResponseDto(
            categories: list
                .map((e) => Category.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        _ => const CategoriesResponseDto(categories: []),
      };

  @override
  List<Object?> get props => [categories];
}

final class Category extends Equatable {
  final String imageUrl;
  final String name;

  const Category({required this.imageUrl, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        imageUrl: json['imageUrl'] ?? '',
        name: json['name'] ?? '',
      );

  @override
  List<Object?> get props => [imageUrl, name];
}
