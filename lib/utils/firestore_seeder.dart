import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreSeeder {
  final FirebaseFirestore _firestore;

  FirestoreSeeder({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> seedData() async {
    try {
      // Clear existing data
      await _clearCollections();

      // Add banners
      await _addBanners();

      // Add categories
      await _addCategories();

      // Add products
      await _addProducts();

      print('Firestore seeded successfully!');
    } catch (e) {
      print('Error seeding Firestore: $e');
    }
  }

  Future<void> _clearCollections() async {
    final collections = ['banners', 'categories', 'products'];
    for (final collection in collections) {
      final snapshot = await _firestore.collection(collection).get();
      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
    }
  }

  Future<void> _addBanners() async {
    final banners = [
      {
        'imageUrl': 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=800',
        'link': 'https://example.com/banner1',
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1607082349566-187342175e2f?w=800',
        'link': 'https://example.com/banner2',
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1607083206968-13611e3d76db?w=800',
        'link': 'https://example.com/banner3',
      },
    ];

    for (final banner in banners) {
      await _firestore.collection('banners').add(banner);
    }
  }

  Future<void> _addCategories() async {
    final categories = [
      {
        'name': 'Electronics',
        'imageUrl': 'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=200',
      },
      {
        'name': 'Fashion',
        'imageUrl': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=200',
      },
      {
        'name': 'Home',
        'imageUrl': 'https://images.unsplash.com/photo-1484101403633-562f891dc89a?w=200',
      },
      {
        'name': 'Beauty',
        'imageUrl': 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=200',
      },
      {
        'name': 'Sports',
        'imageUrl': 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=200',
      },
    ];

    for (final category in categories) {
      await _firestore.collection('categories').add(category);
    }
  }

  Future<void> _addProducts() async {
    final products = [
      {
        'name': 'Wireless Headphones',
        'imageUrl': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
        'price': 99.99,
        'isFavorite': false,
        'isPopular': true,
      },
      {
        'name': 'Smart Watch',
        'imageUrl': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
        'price': 199.99,
        'isFavorite': false,
        'isPopular': true,
      },
      {
        'name': 'Running Shoes',
        'imageUrl': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
        'price': 79.99,
        'isFavorite': false,
        'isPopular': true,
      },
      {
        'name': 'Designer Handbag',
        'imageUrl': 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=400',
        'price': 299.99,
        'isFavorite': false,
        'isPopular': true,
      },
      {
        'name': 'Coffee Maker',
        'imageUrl': 'https://images.unsplash.com/photo-1570087935864-1a6d4f0d9363?w=400',
        'price': 149.99,
        'isFavorite': false,
        'isPopular': true,
      },
    ];

    for (final product in products) {
      await _firestore.collection('products').add(product);
    }
  }
} 