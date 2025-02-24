import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Set the color to white and bold
        ),
        backgroundColor: Color(0xFF7B3F00), // Dark brown shade for app bar
        iconTheme: IconThemeData(color: Colors.white), // Set the arrow icon color to white
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5, // Set width to 50% of the screen
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (ctx, i) => Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    elevation: 3,
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(cart.items.values.toList()[i].imageUrl),
                      ),
                      title: Text(
                        cart.items.values.toList()[i].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Total: \$${cart.items.values.toList()[i].price * cart.items.values.toList()[i].quantity}',
                        style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${cart.items.values.toList()[i].quantity} x',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7B3F00), // Dark brown shade for quantity text
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.brown), // Darker shade for delete icon
                            onPressed: () {
                              cart.removeItem(cart.items.values.toList()[i].id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5, // Set width to 50% of the screen
              child: Card(
                margin: EdgeInsets.all(15),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7B3F00), // Dark brown shade for text
                        ),
                      ),
                      Spacer(),
                      Chip(
                        label: Text(
                          '\$${cart.totalAmount}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Color(0xFFA0522D), // Sienna shade for chip background
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFA0522D), // Sienna shade for button background
                        ),
                        child: Text(
                          'ORDER NOW',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF7B3F00), // Dark brown shade for bottom app bar
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thank you for shopping with us!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
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
