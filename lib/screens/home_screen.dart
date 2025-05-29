import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/home/home_cubit.dart';
import '../blocs/home/home_state.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..loadHomeData(),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF8C6F9),
                Color(0xFFF6E6F9),
                Color(0xFFFFFFFF),
              ],
            ),
          ),
          child: SafeArea(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is HomeError) {
                  return Center(child: Text(state.message));
                }
                if (state is HomeLoaded) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context),
                        const SizedBox(height: 18),
                        _buildSearchBar(context),
                        const SizedBox(height: 18),
                        _buildHorizontalMenu(context, state.categories),
                        const SizedBox(height: 18),
                        _buildCashbackBanner(context, state.banners),
                        const SizedBox(height: 28),
                        _buildPopularOfferSection(context, state.popularProducts),
                        const SizedBox(height: 32),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
        bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.person, color: Colors.grey, size: 30),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Wilson Junior',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Premium',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              _circleIcon(Icons.card_giftcard),
              const SizedBox(width: 10),
              _circleIcon(Icons.notifications_none),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleIcon(IconData icon) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.black54, size: 22),
      alignment: Alignment.center,
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(Icons.search, color: Colors.black38),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Search',
                      style: TextStyle(color: Colors.black38, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.tune, color: Colors.black38),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalMenu(BuildContext context, List<CategoryModel> categories) {
    final items = categories.isNotEmpty
        ? categories.map((cat) => {'icon': Icons.category, 'label': cat.name}).toList()
        : [
            {'icon': Icons.percent, 'label': 'Earn 100%'},
            {'icon': Icons.receipt_long, 'label': 'Tax note'},
            {'icon': Icons.workspace_premium, 'label': 'Premium'},
            {'icon': Icons.sports_esports, 'label': 'Challenge'},
            {'icon': Icons.more_horiz, 'label': 'More'},
          ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.map((item) {
          return Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(item['icon'] as IconData, color: Colors.pinkAccent, size: 26),
                alignment: Alignment.center,
              ),
              const SizedBox(height: 6),
              Text(
                item['label'] as String,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCashbackBanner(BuildContext context, List<BannerModel> banners) {
    if (banners.isEmpty) return const SizedBox();
    final banner = banners.first;
    // Use static fallbacks (instead of dynamic getters) for banner fields.
    const String bannerTitle = 'Shop with 100% cashback';
    const String bannerSubtitle = 'On Shopee';
    const String bannerButtonText = 'I want!';
    const String bannerOfferText = 'Best offer!';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xFFB2A3F8), Color(0xFFF8C6F9)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                child: Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          bannerTitle,
                          style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          bannerSubtitle,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pinkAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                              ),
                              child: Text(bannerButtonText),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              bannerOfferText,
                              style: const TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: (banner.imageUrl != null && banner.imageUrl.isNotEmpty)
                    ? Image.network(
                        banner.imageUrl,
                        fit: BoxFit.contain,
                        height: 90,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 90,
                            color: Colors.grey[200],
                            child: const Icon(Icons.image, color: Colors.grey, size: 30),
                          );
                        },
                      )
                    : Container(
                        height: 90,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image, color: Colors.grey, size: 30),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularOfferSection(BuildContext context, List<ProductModel> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Most popular offer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              Text(
                'See all',
                style: TextStyle(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: products.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductCard(context, product);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, ProductModel product) {
    // Use a static fallback (for example, "") for product cashback if ProductModel does not have a getter (or if the Firestore document does not have that field).
    const String productCashback = "";
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product_details_static',
        );
      },
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  child: (product.imageUrl != null && product.imageUrl.isNotEmpty)
                      ? Image.network(
                          product.imageUrl,
                          height: 100,
                          width: 160,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 100,
                              width: 160,
                              color: Colors.grey[200],
                              child: const Icon(Icons.image, color: Colors.grey, size: 30),
                            );
                          },
                        )
                      : Container(
                          height: 100,
                          width: 160,
                          color: Colors.grey[200],
                          child: const Icon(Icons.image, color: Colors.grey, size: 30),
                        ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      product.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: product.isFavorite ? Colors.pinkAccent : Colors.pinkAccent,
                      size: 20,
                    ),
                    padding: const EdgeInsets.all(6),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        (productCashback.isEmpty ? "" : (productCashback + " cashback")),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.percent, color: Colors.pinkAccent, size: 14),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
