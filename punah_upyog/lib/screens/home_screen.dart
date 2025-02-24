import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'products_overview_screen.dart';
import 'cart_screen.dart';
import 'sell_item_screen.dart';
import '../providers/cart_provider.dart';
import '../widgets/badge.dart' as custom_badge;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = constraints.maxWidth > 600;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: isTablet ? 120.0 : 100.0,
            title: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.0),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/iit_mandi_logo.png',
                      height: isTablet ? 80.0 : 60.0,
                      width: isTablet ? 80.0 : 60.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: isTablet ? 30.0 : 20.0),
                Text(
                  'पुनः उपयोग',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 50.0 : 40.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF7B3F00), Color(0xFFFFD700)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: isTablet ? 300.0 : 200.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.white70),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Consumer<CartProvider>(
                builder: (_, cart, ch) => Row(
                  children: [
                    custom_badge.Badge(
                      value: cart.itemCount.toString(),
                      child: ch!,
                    ),
                    SizedBox(width: 8),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart, size: 30.0),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
              ),
              PopupMenuButton<String>(
                icon: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile_image.png'), // Replace with your profile image path
                  radius: 20.0,
                ),
                onSelected: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: $value')),
                  );
                  // Handle actions based on selection
                  switch (value) {
                    case 'myAccount':
                      // Navigate to My Account screen
                      break;
                    case 'myWallet':
                      // Navigate to My Wallet screen
                      break;
                    case 'previousOrders':
                      // Navigate to Previous Orders screen
                      break;
                    case 'savedAddresses':
                      // Navigate to Saved Addresses screen
                      break;
                    case 'settings':
                      // Navigate to Settings screen
                      break;
                    case 'feedback':
                      // Navigate to Feedback screen
                      break;
                    case 'helpSupport':
                      // Navigate to Help and Support screen
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 'myAccount',
                    child: Row(
                      children: [
                        Icon(Icons.person, color: Colors.black),
                        SizedBox(width: 10),
                        Text('My Account'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'myWallet',
                    child: Row(
                      children: [
                        Icon(Icons.wallet, color: Colors.black),
                        SizedBox(width: 10),
                        Text('My Wallet'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'previousOrders',
                    child: Row(
                      children: [
                        Icon(Icons.shopping_bag, color: Colors.black),
                        SizedBox(width: 10),
                        Text('Previous Orders'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'savedAddresses',
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.black),
                        SizedBox(width: 10),
                        Text('Saved Addresses'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'settings',
                    child: Row(
                      children: [
                        Icon(Icons.settings, color: Colors.black),
                        SizedBox(width: 10),
                        Text('Settings'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'feedback',
                    child: Row(
                      children: [
                        Icon(Icons.feedback, color: Colors.black),
                        SizedBox(width: 10),
                        Text('Feedback'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'helpSupport',
                    child: Row(
                      children: [
                        Icon(Icons.support, color: Colors.black),
                        SizedBox(width: 10),
                        Text('Help and Support'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(isTablet ? 32.0 : 16.0),
            child: ProductsOverviewScreen(),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'sellItem',
                backgroundColor: Color(0xFF7B3F00),
                onPressed: () {
                  Navigator.of(context).pushNamed(SellItemScreen.routeName);
                },
                child: Icon(Icons.add, color: Colors.white),
              ),
              SizedBox(height: isTablet ? 24 : 16),
              FloatingActionButton.extended(
                heroTag: 'cart',
                backgroundColor: Color(0xFF7B3F00),
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                label: Text('Cart', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
