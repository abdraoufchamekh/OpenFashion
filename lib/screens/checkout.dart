import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:open_fashion/components/cart_widget.dart';
import 'package:open_fashion/components/custom_appbar.dart';
import 'package:open_fashion/components/custom_button.dart';
import 'package:open_fashion/components/custom_text.dart';
import 'package:open_fashion/components/header.dart';
import 'package:open_fashion/core/colors.dart';
import 'package:open_fashion/screens/place_order.dart';

class Checkout extends StatefulWidget {
  const Checkout({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.descp,
  });
  final String image;
  final String name;
  final int price;
  final String descp;

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int selectedQty = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(isBlackk: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            const Header(title: "Checkout"),

            CartWidget(
              image: widget.image,
              name: widget.name,
              descp: widget.descp,
              price: widget.price,
              qty: selectedQty,
              onChanged: (v) {
                setState(() {
                  selectedQty = v;
                });
              },
            ),

            promo(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "Est. Total", color: AppColors.primary),
                CustomText(
                  text: "\$ ${widget.price * selectedQty}",
                  color: Colors.red.shade200,
                ),
              ],
            ),
            const Gap(20),
            Button(
              isSvgg: true,
              title: "Checkout",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) {
                      return PlaceOrder(
                        image: widget.image,
                        name: widget.name,
                        desp: widget.descp,
                        qty: selectedQty,
                        price: widget.price,
                        total: widget.price * selectedQty,
                      );
                    },
                  ),
                );
              },
            ),
            const Gap(70),
          ],
        ),
      ),
    );
  }
}

Widget promo() {
  return Column(
    children: [
      const Gap(20),
      const Divider(),
      const Gap(20),
      Row(
        children: [
          SvgPicture.asset("assets/svgs/promo.svg", width: 28),
          const Gap(20),
          const CustomText(text: "ADD Promo Code", color: AppColors.primary),
        ],
      ),
      const Gap(20),
      const Divider(),
      const Gap(20),
      Row(
        children: [
          SvgPicture.asset("assets/svgs/delivery.svg", width: 25),
          const Gap(20),
          const CustomText(text: "Delivery", color: AppColors.primary),
          const Spacer(),
          const CustomText(text: "FREE", color: AppColors.primary),
          const Gap(5),
        ],
      ),
      const Gap(10),
      const Divider(),
    ],
  );
}
