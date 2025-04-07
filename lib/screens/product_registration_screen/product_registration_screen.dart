import 'package:dummy_project/screens/product_registration_screen/components/action_buttons.dart';
import 'package:dummy_project/screens/product_registration_screen/components/header_section.dart';
import 'package:dummy_project/screens/product_registration_screen/components/product_grid.dart';
import 'package:dummy_project/screens/product_registration_screen/components/search_field.dart';
import 'package:dummy_project/screens/product_registration_screen/models/product.dart';
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
          onPressed: () {},
        ),
        actions: [
          TextButton(
            onPressed: () {},
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
