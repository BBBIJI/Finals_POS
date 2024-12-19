// cart_repository.dart (inside data/repositories)
import 'package:finalproject_pulse/data/model/cart_item_mode.dart';

class CartRepository {
  Map<String, CartItem> _cartItems = {}; // Store cart items

  // Add item to cart
  void addItemToCart(CartItem item) {
    if (_cartItems.containsKey(item.productName)) {
      _cartItems[item.productName]!.quantity += item.quantity;
    } else {
      _cartItems[item.productName] = item;
    }
  }

  // Retrieve cart items
  Map<String, CartItem> getCartItems() {
    return _cartItems;
  }

  // Clear all cart items
  void clearCart() {
    _cartItems.clear();
  }
}
