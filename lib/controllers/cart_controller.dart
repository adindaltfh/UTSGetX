import 'package:get/get.dart';

class CartItem {
  String productName;
  String productImage;
  RxInt quantity; // Menggunakan RxInt agar dapat dipantau oleh GetX

  CartItem({
    required this.productName,
    required this.productImage,
    int quantity = 1,
  }) : quantity = quantity.obs; // Inisialisasi RxInt
}

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs; // Observable untuk mengelola list keranjang

  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity.value);

  void addToCart(String product, String image) {
    int index = cartItems.indexWhere((item) => item.productName == product);
    if (index != -1) {
      cartItems[index].quantity.value += 1; // Tambah kuantitas jika produk sudah ada
    } else {
      cartItems.add(CartItem(productName: product, productImage: image)); // Tambah produk baru
    }
    cartItems.refresh(); // Perbarui RxList agar UI diupdate
  }

  void removeFromCart(String product) {
    cartItems.removeWhere((item) => item.productName == product);
    cartItems.refresh(); // Perbarui RxList setelah penghapusan
  }

  void increaseQuantity(String product) {
    int index = cartItems.indexWhere((item) => item.productName == product);
    if (index != -1) {
      cartItems[index].quantity.value += 1;
      cartItems.refresh(); // Perbarui RxList agar UI diupdate
    }
  }

  void decreaseQuantity(String product) {
    int index = cartItems.indexWhere((item) => item.productName == product);
    if (index != -1 && cartItems[index].quantity.value > 1) {
      cartItems[index].quantity.value -= 1;
      cartItems.refresh(); // Perbarui RxList agar UI diupdate
    }
  }

  // Fungsi untuk menghapus produk sepenuhnya dari keranjang
  void removeProduct(String product) {
    cartItems.removeWhere((item) => item.productName == product);
    cartItems.refresh(); // Memastikan pembaruan UI
  }
}
