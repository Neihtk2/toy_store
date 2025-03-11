import 'package:flutter/material.dart';

class ShoeCard extends StatelessWidget {
  final Map<String, dynamic> shoe;

  ShoeCard({required this.shoe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(
                shoe['image'],
                fit: BoxFit.contain,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Icon(Icons.error, color: Colors.red));
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BEST SELLER',
                  style: TextStyle(fontSize: 12, color: Colors.blue),
                ),
                SizedBox(height: 2),
                Text(
                  shoe['name'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 2),
                Text(
                  shoe['price'],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 16,
                child: Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}