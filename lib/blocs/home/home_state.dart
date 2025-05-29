import 'package:equatable/equatable.dart';
import '../../models/banner_model.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<BannerModel> banners;
  final List<CategoryModel> categories;
  final List<ProductModel> popularProducts;

  const HomeLoaded({
    required this.banners,
    required this.categories,
    required this.popularProducts,
  });

  @override
  List<Object?> get props => [banners, categories, popularProducts];

  HomeLoaded copyWith({
    List<BannerModel>? banners,
    List<CategoryModel>? categories,
    List<ProductModel>? popularProducts,
  }) {
    return HomeLoaded(
      banners: banners ?? this.banners,
      categories: categories ?? this.categories,
      popularProducts: popularProducts ?? this.popularProducts,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
} 