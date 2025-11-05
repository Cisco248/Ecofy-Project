import 'package:e_wms_mobile/core/constants/size.dart';
import 'package:flutter/material.dart';

class TokenGeneratePage extends StatefulWidget {
  const TokenGeneratePage({super.key});

  @override
  State<TokenGeneratePage> createState() => _TokenGeneratePageState();
}

class _TokenGeneratePageState extends State<TokenGeneratePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 32, right: 32, top: 20),
      child: Column(children: [_TokenDisplayCard()]),
    );
  }
}

class _TokenDisplayCard extends StatefulWidget {
  const _TokenDisplayCard();

  @override
  State<_TokenDisplayCard> createState() => __TokenDisplayCardState();
}

class __TokenDisplayCardState extends State<_TokenDisplayCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizeStyle.fullWidth(context),
      height: 200,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('data'), Text('data')],
      ),
    );
  }
}

// class _RedeemTokenSection extends StatefulWidget {
//   const _RedeemTokenSection({super.key});
//
//   @override
//   State<_RedeemTokenSection> createState() => _RedeemTokenSectionState();
// }
//
// class _RedeemTokenSectionState extends State<_RedeemTokenSection> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
