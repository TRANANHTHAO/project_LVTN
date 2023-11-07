
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/enum.dart';

class SizePickerBottomSheet extends StatefulWidget {

  final Function(ProductSize)? onConfirm;

  const SizePickerBottomSheet({
  super.key, this.onConfirm,
  });

  @override
  State<SizePickerBottomSheet> createState() => _SizePickerBottomSheetState();
}

class _SizePickerBottomSheetState extends State<SizePickerBottomSheet> {
  late ProductSize _size;

  @override
  void initState() {
    super.initState();
    _size = ProductSize.medium;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        const Text(
            "Chọn kích cỡ",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Column(
          children: ProductSize.values.map((size)
            => CustomRadioItem(
                checked: _size == size,
                value: size.name,
                onChanged: () {
                  setState(() {
                    _size = size;
                  });
                }
            )
          ).toList()
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 236, 62, 9),
                ),
                onPressed: () => widget.onConfirm?.call(_size),
                child: const Text('Đặt Hàng'),
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 216, 24, 10),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Hủy'),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

class CustomRadioItem extends StatelessWidget {
  final bool checked;
  final String value;
  final Function()? onChanged;

  const CustomRadioItem({
    super.key, required this.checked, required this.value, this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(checked
                ? Icons.radio_button_checked_rounded
                : Icons.radio_button_off_rounded,
              color: Colors.deepOrange,
            ),
            const SizedBox(width: 10,),
            Text(value.toUpperCase())
          ],
        ),
      ),
    );
  }
}