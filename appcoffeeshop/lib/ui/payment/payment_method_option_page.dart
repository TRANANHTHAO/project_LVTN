
import 'package:appcoffeeshop/models/enum.dart';
import 'package:flutter/material.dart';

class PaymentMethodOptionPage extends StatefulWidget {
  const PaymentMethodOptionPage({super.key,
    this.onCheckOut
  });

  final Function(PaymentMethod)? onCheckOut;

  @override
  State<PaymentMethodOptionPage> createState() => _PaymentMethodOptionPageState();
}

class _PaymentMethodOptionPageState extends State<PaymentMethodOptionPage> {
  late PaymentMethod _paymentMethod;

  @override
  void initState() {
    super.initState();
    _paymentMethod = PaymentMethod.cash;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 105,
        leadingWidth: 50,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Chọn phương thức thanh toán',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Lato', fontWeight: FontWeight.bold, wordSpacing: 2),
        ),
        flexibleSpace: Container(
          color: const Color.fromARGB(255, 19, 18, 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            _buildPaymentMethodCard(
              method: PaymentMethod.cash,
              label: "Cash on delivery",
              description: "Description",
              icon: const Icon(Icons.card_membership_sharp, size: 30, color: Colors.brown,),
              onTap: () {
                setState(() {
                  _paymentMethod = PaymentMethod.cash;
                });
              }
            ),
            const SizedBox(height: 16,),
            _buildPaymentMethodCard(
              method: PaymentMethod.paypal,
                label: "Paypal",
                description: "Description",
                icon: const Icon(Icons.account_balance_wallet_rounded, size: 30, color: Colors.brown,),
                onTap: () {
                  setState(() {
                    _paymentMethod = PaymentMethod.paypal;
                  });
                }
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: () => widget.onCheckOut?.call(_paymentMethod),
                child: Container(
                  width: MediaQuery.of(context).size.width - 2 * 16,
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text(
                    "Đặt hàng",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard({
    required String label,
    required Widget icon,
    required String description,
    required PaymentMethod method,
    Function()? onTap
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 8,
                  blurRadius: 8
                )
              ],
              borderRadius: BorderRadius.circular(12)
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                CircleAvatar(
                  child: CircleAvatar(child: icon, radius: 25, backgroundColor: Colors.white,),
                  radius: 30,
                  backgroundColor: Colors.deepOrange,
                ),
                const SizedBox(width: 16,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontFamily: "Lato",
                          fontSize: 18,
                          color: Colors.black
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Text(
                        description,
                        style: const TextStyle(
                            fontFamily: "Lato",
                            fontSize: 16,
                            color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                ),
                _paymentMethod == method
                    ? Icon(Icons.radio_button_checked_rounded, color: Colors.deepOrange,)
                    : Icon(Icons.radio_button_off_rounded)
              ],
            ),
          ),
    );
  }
}
