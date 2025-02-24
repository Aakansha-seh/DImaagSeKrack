import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl: '/assets/images/red_shirt.jpeg',
    ),
    Product(
      id: 'p2',
      title: 'GATE Preparation Books',
      description:
          'Are you gearing up for the GATE (Graduate Aptitude Test in Engineering) and looking for high-quality study material without breaking the bank? Look no further! We have a curated selection of second-hand GATE preparation books that will help you achieve your academic goals.',
      price: 720.00,
      imageUrl: '/assets/images/prep_books.jpeg',
    ),
    Product(
      id: 'p3',
      title: 'The Secret History Novel',
      description:
          'Are you a book lover always on the hunt for your next captivating read? Dive into our collection of second-hand novels and experience the magic of storytelling at an unbeatable price.',

      price: 69.99,
      imageUrl: '/assets/images/the_secret_history.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Mattress',
      description:
          'I am leaving the campus and I don\'t intend to carry it with me. It is in good condition.',
      price: 500.00,
      imageUrl: '/assets/images/mattress.jpeg',
    ),
    Product(
      id: 'p5',
      title: 'ED Kit',
      description:
          'I have my ED kit which serves no purpose to me. It includes:\n1. Roller scale(30cm)\n2. Geometry Box\n3. French Curves\n4. 30 cm long scale',
      price: 100,
      imageUrl: '/assets/images/ed_kit.jpeg',
    ),
    Product(
      id: 'p6',
      title: 'Bucket and Mug',
      description: 'A transparent basket with a mug in a decent condition are open to sale. If you are interested....',
      price: 59.99,
      imageUrl: '/assets/images/bucket_mug.jpeg',
    ),
    Product(
      id: 'p7',
      title: 'Shoes',
      description: 'A nice pair of shoes which no longer serves my taste. They are very comfortable and have cushiony sole.',
      price: 59.99,
      imageUrl: '/assets/images/shoes.jpeg',
    ),
    Product(
      id: 'p8',
      title: 'My Hostel Room',
      description: 'Just for fun... LOL',
      price: 59.99,
      imageUrl: '/assets/images/hostel_room.jpeg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
