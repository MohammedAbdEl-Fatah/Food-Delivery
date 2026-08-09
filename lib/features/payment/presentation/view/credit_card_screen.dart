import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/router/contents_router.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({super.key});

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';

  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onCreditCardModelChange(CreditCardModel data) {
    setState(() {
      cardNumber = data.cardNumber;
      expiryDate = data.expiryDate;
      cardHolderName = data.cardHolderName;
      cvvCode = data.cvvCode;
      isCvvFocused = data.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    String price = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (brand) {},
              cardBgColor: ColorManager.primary,
              cardType: CardType.discover,
            ),

            CreditCardForm(
              formKey: formKey,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              onCreditCardModelChange: onCreditCardModelChange,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.popAndPushNamed(context, ContentsRouter.cashOnDeliveryScreen, arguments: price);
                  //* there some error in fields, show error message
                }
              },
              child: const Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }
}
