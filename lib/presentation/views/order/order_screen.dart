import 'package:flutter/material.dart';

class OrderListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      "store": "UUMIR Store",
      "status": "Waiting for delivery",
      "image": 'https://www.manhattantoy.com/cdn/shop/products/Untitled-1.jpg?v=1673024231&width=1000', // Thay bằng link ảnh thật
      "name": "Túi xách cho nữ hình dáng dễ thương màu trắng...",
      "quantity": 1,
      "price": 15.00,
    },
    {
      "store": "Fashion Hub",
      "status": "Shipped",
      "image": 'https://www.manhattantoy.com/cdn/shop/products/Untitled-1.jpg?v=1673024231&width=1000', // Link ảnh khác
      "name": "Áo thun nam phong cách Hàn Quốc",
      "quantity": 2,
      "price": 25.00,
    },
    {
      "store": "Tech Gadgets",
      "status": "Waiting for delivery",
      "image": 'https://www.manhattantoy.com/cdn/shop/products/Untitled-1.jpg?v=1673024231&width=1000', // Link ảnh khác
      "name": "Tai nghe Bluetooth không dây",
      "quantity": 1,
      "price": 40.00,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "My Orders",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return _buildOrderItem(orders[index]);
        },
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> order) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5, spreadRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tên cửa hàng + trạng thái đơn hàng
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.store),
                  Text(order["store"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              
              Text(
                order["status"],
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 10),

          // Hình ảnh + Chi tiết sản phẩm
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  order["image"],
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      order["name"],
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,

                    ),
                    SizedBox(height: 5),
                    Text("x${order["quantity"]}", style: TextStyle(fontSize: 14, color: Colors.grey)),
                    SizedBox(height: 5),
                    Text(
                      "\$${order["price"].toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(thickness: 1, height: 30),

          // Tổng tiền
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${order["quantity"]} Product", style: TextStyle(color: Colors.grey)),
               
              Row(
                children: [
                  Text(
                "Total: ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
                  Text(
                    "\$${(order["quantity"] * order["price"]).toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
          Divider(thickness: 1, height: 30),
     

          // Lưu ý
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Văn bản cảnh báo
          Expanded(
            child: Text(
              'Please only click "Order Received" once the order has been delivered to you and there are no problems with the product',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                
              ),
              maxLines: 3,
                      overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 10),

          // Nút "Order Received"
          ElevatedButton(
            onPressed:  () {
              
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              disabledBackgroundColor: Colors.red.shade200, // Làm mờ khi disable
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Order Received",
              style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    

          SizedBox(height: 10),

          // Nút xác nhận đơn hàng
         
        ],
      ),
    );
  }
}
