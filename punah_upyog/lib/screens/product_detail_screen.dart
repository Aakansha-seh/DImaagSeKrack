import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../providers/cart_provider.dart'; // Import the CartProvider
import '../screens/cart_screen.dart'; // Import the CartScreen

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findById(productId);
    final cart = Provider.of<CartProvider>(context, listen: false); // Access the cart provider

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loadedProduct.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22, // Larger font size for the title
          ),
        ),
        backgroundColor: Colors.brown.shade700, // Brown shade for app bar
        iconTheme: IconThemeData(color: Colors.white), // Set the arrow icon color to white
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff462813), Color(0xff75492a)], // Brown to coffee color gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), // Adjusted padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Product Image with Hero Animation (Original Size)
              Hero(
                tag: loadedProduct.id, // Hero animation for smooth transitions
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8, // Limit width to 80% of screen
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        loadedProduct.imageUrl,
                        fit: BoxFit.scaleDown, // Ensure the image fits within its original size
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(Icons.error, color: Colors.red),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24), // Spacing between image and details

              // Product Price
              Text(
                '₹${loadedProduct.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Color(0xff75492a), // Brown shade for price
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16), // Spacing between price and description

              // Product Description
              Text(
                loadedProduct.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade800, // Dark grey for description
                  fontWeight: FontWeight.w500, // Medium font weight
                ),
              ),
              SizedBox(height: 24), // Spacing between description and buttons

              // Action Buttons (Centered and Close Together)
              Center(
                child: Wrap(
                  spacing: 16, // Reduced spacing between buttons
                  alignment: WrapAlignment.center, // Center the buttons
                  children: <Widget>[
                    // Buy Now Button
                    ElevatedButton(
                      onPressed: () {
                        cart.addItem(
                          loadedProduct.id,
                          loadedProduct.price,
                          loadedProduct.title,
                          loadedProduct.imageUrl,
                        ); // Add the item to the cart
                        Navigator.of(context).pushNamed(CartScreen.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffac8563), // Brown shade for "Buy Now" button
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5, // Add elevation for a raised effect
                      ),
                      child: Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Add to Cart Button
                    ElevatedButton(
                      onPressed: () {
                        cart.addItem(
                          loadedProduct.id,
                          loadedProduct.price,
                          loadedProduct.title,
                          loadedProduct.imageUrl,
                        ); // Add the item to the cart
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added to cart!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff99837c), // Brown shade for "Add to Cart" button
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5, // Add elevation for a raised effect
                      ),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        color: Colors.brown.shade700,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'पुनः उपयोग',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}