import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_state.dart';
import '../../models/banner_model.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';

class HomeCubit extends Cubit<HomeState> {
  final FirebaseFirestore _firestore;

  HomeCubit({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        super(HomeInitial());

  Future<void> loadHomeData() async {
    try {
      emit(HomeLoading());

      // Fetch banners
      final bannersSnapshot = await _firestore.collection('banners').get();
      final banners = bannersSnapshot.docs
          .map((doc) => BannerModel.fromMap({...doc.data(), 'id': doc.id}))
          .toList();

      // Fetch categories
      final categoriesSnapshot = await _firestore.collection('categories').get();
      final categories = categoriesSnapshot.docs
          .map((doc) => CategoryModel.fromMap({...doc.data(), 'id': doc.id}))
          .toList();

      // Fetch popular products
      final productsSnapshot = await _firestore
          .collection('products')
          .where('isPopular', isEqualTo: true)
          .get();
      final popularProducts = productsSnapshot.docs
          .map((doc) => ProductModel.fromMap({...doc.data(), 'id': doc.id}))
          .toList();

      emit(HomeLoaded(
        banners: banners,
        categories: categories,
        popularProducts: popularProducts,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> toggleFavorite(String productId, bool currentStatus) async {
    try {
      final state = this.state;
      if (state is HomeLoaded) {
        await _firestore.collection('products').doc(productId).update({
          'isFavorite': !currentStatus,
        });

        final updatedProducts = state.popularProducts.map((product) {
          if (product.id == productId) {
            return product.copyWith(isFavorite: !currentStatus);
          }
          return product;
        }).toList();

        emit(state.copyWith(popularProducts: updatedProducts));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
} 