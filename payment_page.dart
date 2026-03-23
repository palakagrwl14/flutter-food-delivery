// lib/screens/payment_page.dart
import 'package:flutter/material.dart';
import '../utils/inr.dart';
import 'order_success_page.dart';

enum PaymentMethod { upi, card, cod }

class PaymentPage extends StatefulWidget {
  final num totalAmount;
  const PaymentPage({super.key, required this.totalAmount});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentMethod _method = PaymentMethod.upi;

  void _payNow() async {
    // yahan real gateway integrate kar sakte ho; abhi dummy delay
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    Navigator.of(context).pop(); // loader close

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => OrderSuccessPage(amount: widget.totalAmount),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalTxt = inr(widget.totalAmount);
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text('Total Payable'),
                trailing: Text(totalTxt, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Select Payment Method', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 8),
            RadioListTile(
              value: PaymentMethod.upi,
              groupValue: _method,
              onChanged: (v) => setState(() => _method = v!),
              title: const Text('UPI (GPay/PhonePe/Paytm)'),
            ),
            RadioListTile(
              value: PaymentMethod.card,
              groupValue: _method,
              onChanged: (v) => setState(() => _method = v!),
              title: const Text('Credit/Debit Card'),
            ),
            RadioListTile(
              value: PaymentMethod.cod,
              groupValue: _method,
              onChanged: (v) => setState(() => _method = v!),
              title: const Text('Cash on Delivery'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _payNow,
                child: Text('Pay ${inr(widget.totalAmount)}'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
