import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toyland_mobile/data/models/watch_model.dart';

class WatchCard extends StatelessWidget {
  final WatchModel watch;

  WatchCard({required this.watch});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
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
                watch.images[0].url,
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
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  watch.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[800]!.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        watch.branch.name,
                        style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontSize: 10,
                        ),
                      ),
                    ),
                    SizedBox(width: 4),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red[700]!.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        'Yêu thích',
                        style: TextStyle(color: Colors.red[700], fontSize: 10),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  NumberFormat("#,###.###", "en_US").format(
                    double.parse(watch.price),
                  ), // Chuyển String thành double trước khi format
                  style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    SizedBox(width: 2),
                    Text(
                      '4.5',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Đã bán 100',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      watch.category.name,
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        '-20%',
                        style: TextStyle(color: Colors.red, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
