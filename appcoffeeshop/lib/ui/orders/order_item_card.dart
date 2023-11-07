import 'dart:math';

import 'package:appcoffeeshop/models/order_status.dart';
import 'package:appcoffeeshop/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/order_item.dart';
import 'orders_manager.dart';

import 'package:provider/provider.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem order;

  const OrderItemCard(this.order, {super.key});

  @override
  State<OrderItemCard> createState() => _OrderItemCartState();
}

class _OrderItemCartState extends State<OrderItemCard> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 248, 225, 203),
      margin: const EdgeInsets.all(18),
      child: Column(
        children: <Widget>[
          buildOrderSummary(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
          ),
          _acceptedAndDenied(widget.order),
          const Divider(
            thickness: 2,
            color: Color.fromARGB(255, 2, 31, 52),
          ),
          if (_expanded) buildOrderDetails()
        ],
      ),
    );
  }

  Widget buildOrderDetails() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      height: min(widget.order.productCount * 30.0 + 5, 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
      ),
      child: ListView(
        children: widget.order.products
                ?.map(
                  (prod) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        prod.title,
                        style: const TextStyle(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        '${prod.quantity}',
                        style: const TextStyle(
                          letterSpacing: 1,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${prod.price}00 VND',
                        style: const TextStyle(
                          letterSpacing: 1,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
                .toList() ??
            [],
      ),
    );
  }

  Widget buildOrderSummary() {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tổng đơn: ${widget.order.amount}00 VND',
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 3, 34, 81),
            ),
          ),
          Text(
            'Trạng thái đơn hàng: ${widget.order.orderStatus}',
            style: const TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 56, 61, 70),
            ),
          ),
          Text(
            'Địa chỉ: ${widget.order.address}',
            style: const TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 56, 61, 70),
            ),
          ),
          Text(
            'Số điện thoại: ${widget.order.sdt}',
            style: const TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 56, 61, 70),
            ),
          ),
          Text(
            'Tên: ${widget.order.ten}',
            style: const TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 56, 61, 70),
            ),
          ),
        ],
      ),
      subtitle: Text(
        DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
        style: const TextStyle(
          fontSize: 15,
          color: Color.fromARGB(255, 56, 61, 70),
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
        icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
      ),
    );
  }

  Widget _acceptedAndDenied(OrderItem item) {
    print("${item.orderStatus}###");
    return AuthService.isAdmin && item.orderStatus == OrderStatus.WAITING.value
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<OrdersManager>().acceptOrder(item);
                  },
                  child: const Text('Chấp nhận'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    context.read<OrdersManager>().denyOrder(item);
                  },
                  child: const Text('Huỷ'),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
