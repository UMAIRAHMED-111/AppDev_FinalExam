import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductModel;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade100,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProductImage(product),
                      const SizedBox(height: 20),
                      _buildProductInfo(product),
                      const SizedBox(height: 20),
                      _buildCardCarousel(),
                      const SizedBox(height: 20),
                      _buildTransactionList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Product Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(ProductModel product) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(product.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProductInfo(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardCarousel() {
    return SizedBox(
      height: 200,
      child: PageView(
        children: [
          _buildCard(
            'https://raw.githubusercontent.com/flutter/website/main/examples/layout/responsive/_card_1.png',
            'Visa Card',
            '**** **** **** 1234',
          ),
          _buildCard(
            'https://raw.githubusercontent.com/flutter/website/main/examples/layout/responsive/_card_2.png',
            'Master Card',
            '**** **** **** 5678',
          ),
          _buildCard(
            'https://raw.githubusercontent.com/flutter/website/main/examples/layout/responsive/_card_3.png',
            'American Express',
            '**** **** **** 9012',
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String imageUrl, String cardName, String cardNumber) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    final transactions = [
      {
        'title': 'Shopping at Walmart',
        'amount': '-\$45.99',
        'date': 'Today, 2:30 PM',
        'icon': Icons.shopping_bag,
      },
      {
        'title': 'Netflix Subscription',
        'amount': '-\$14.99',
        'date': 'Yesterday, 10:15 AM',
        'icon': Icons.movie,
      },
      {
        'title': 'Salary Deposit',
        'amount': '+\$2,500.00',
        'date': 'Mar 15, 9:00 AM',
        'icon': Icons.account_balance,
      },
      {
        'title': 'Uber Ride',
        'amount': '-\$23.50',
        'date': 'Mar 14, 6:45 PM',
        'icon': Icons.directions_car,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Recent Transactions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  transaction['icon'] as IconData,
                  color: Colors.blue,
                ),
              ),
              title: Text(transaction['title'] as String),
              subtitle: Text(transaction['date'] as String),
              trailing: Text(
                transaction['amount'] as String,
                style: TextStyle(
                  color: (transaction['amount'] as String).startsWith('+')
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomBarItem(Icons.home, 'Home', true),
            _buildBottomBarItem(Icons.credit_card, 'Cards', false),
            _buildBottomBarItem(Icons.history, 'History', false),
            _buildBottomBarItem(Icons.person, 'Profile', false),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBarItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
} 