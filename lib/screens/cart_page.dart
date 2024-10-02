import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(child: Text('No items in the cart'));
        }
        return ListView.builder(
          itemCount: cartController.cartItems.length,
          itemBuilder: (context, index) {
            final item = cartController.cartItems[index];
            return ListTile(
              leading: Image.asset(item.productImage, width: 50),
              title: Text(item.productName),
              subtitle: Obx(() => Text('Quantity: ${item.quantity.value}')), // Menggunakan Obx untuk memantau `quantity`
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      cartController.decreaseQuantity(item.productName);
                    },
                  ),
                  Obx(() => Text(item.quantity.value.toString())), // Gunakan `Obx` untuk memantau perubahan `quantity`
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      cartController.increaseQuantity(item.productName);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red), // Ikon tong sampah untuk menghapus
                    onPressed: () {
                      // Tampilkan dialog konfirmasi sebelum menghapus produk
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirm Removal'),
                            content: Text(
                                'Are you sure you want to remove "${item.productName}" from the cart?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Tutup dialog konfirmasi
                                },
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  cartController.removeProduct(item.productName); // Hapus produk dari keranjang
                                  Navigator.of(context).pop(); // Tutup dialog setelah penghapusan
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
