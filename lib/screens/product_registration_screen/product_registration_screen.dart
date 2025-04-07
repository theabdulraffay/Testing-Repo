import 'package:flutter/material.dart';

class ProductRegistrationScreen extends StatefulWidget {
  const ProductRegistrationScreen({super.key});

  @override
  State<ProductRegistrationScreen> createState() =>
      _ProductRegistrationScreenState();
}

class _ProductRegistrationScreenState extends State<ProductRegistrationScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'INFĒRA',
      imageUrl: 'assets/images/infera_black.png',
      isSelected: false,
    ),
    Product(
      id: '2',
      name: 'INFĒRA Mini',
      imageUrl: 'assets/images/infera_mini.png',
      isSelected: false,
    ),
    Product(
      id: '3',
      name: 'BLU',
      imageUrl: 'assets/images/blu.png',
      isSelected: false,
    ),
    Product(
      id: '4',
      name: 'INFĒRA',
      imageUrl: 'assets/images/infera_black.png',
      isSelected: false,
    ),
    Product(
      id: '5',
      name: 'INFĒRA Mini',
      imageUrl: 'assets/images/infera_mini.png',
      isSelected: false,
    ),
    Product(
      id: '6',
      name: 'BLU',
      imageUrl: 'assets/images/blu.png',
      isSelected: false,
    ),
  ];

  List<Product> get filteredProducts {
    if (_searchController.text.isEmpty) {
      return _products;
    }

    return _products
        .where((product) => product.name
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle skip action
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderSection2(
              title: 'Register your Infera product',
              subtitle:
                  'This will help you to get better results with our products. You can select more than one',
            ),
            const SizedBox(height: 20),

            // Search Field
            SearchField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    // Trigger rebuild with filtered products
                  });
                }),
            const SizedBox(height: 20),

            // Products Grid
            Expanded(
              child: ProductGrid(
                products: filteredProducts,
                onProductSelected: (product) {
                  setState(() {
                    final index =
                        _products.indexWhere((p) => p.id == product.id);
                    if (index != -1) {
                      _products[index].isSelected =
                          !_products[index].isSelected;
                    }
                  });
                },
              ),
            ),

            // Action Buttons
            const SizedBox(height: 20),
            ActionButtons(
              onSkip: () {
                // Handle skip action
              },
              onContinue: () {
                // Handle continue action with selected products
                final selectedProducts =
                    _products.where((p) => p.isSelected).toList();
                print(
                    'Selected products: ${selectedProducts.map((p) => p.name).join(', ')}');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSection2 extends StatelessWidget {
  final String title;
  final String subtitle;

  const HeaderSection2({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          hintText: 'Textfield',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onProductSelected;

  const ProductGrid({
    super.key,
    required this.products,
    required this.onProductSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onSelected: () => onProductSelected(products[index]),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onSelected;

  const ProductCard({
    super.key,
    required this.product,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(10),
                child: Center(
                  // In a real app, use Image.asset or Image.network here
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            product.name.contains('Mini')
                                ? Icons.straighten
                                : Icons.hourglass_bottom,
                            size: 60,
                            color: product.name.contains('BLU')
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onSelected,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: product.isSelected
                            ? Colors.blue
                            : Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: product.isSelected
                        ? const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.blue,
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ActionButtons extends StatelessWidget {
  final VoidCallback onSkip;
  final VoidCallback onContinue;

  const ActionButtons({
    super.key,
    required this.onSkip,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onSkip,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey[400]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: onContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A3F35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Product {
  final String id;
  final String name;
  final String imageUrl;
  bool isSelected;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isSelected,
  });
}
