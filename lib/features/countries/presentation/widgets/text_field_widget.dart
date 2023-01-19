import 'package:flutter/material.dart';

import '../../../../core/utils/app_constants.dart';

class ProductTextFieldWidget extends StatefulWidget {
  const ProductTextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductTextFieldWidget> createState() => _ProductTextFieldWidgetState();
}

class _ProductTextFieldWidgetState extends State<ProductTextFieldWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: cWhiteColor,
        boxShadow: const [BoxShadow(color: cBackgroundColor, blurRadius: 40)],
      ),
      height: 65,
      margin: const EdgeInsets.only(top: 27),
      padding: const EdgeInsets.fromLTRB(13, 2, 0, 0),
      child: Center(
        child: Row(
          children: [
            const Icon(Icons.search, color: cBlackColor,size: 24,),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                textAlignVertical: TextAlignVertical.top,
                cursorColor: cBlackColor,
                cursorHeight: 17,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 0),
                  hintText: "Search",
                  hintStyle: TextStyle(fontSize: 14, color: Colors.black26),
                  prefixIconConstraints: BoxConstraints(
                    maxWidth: 30,
                    maxHeight: 30,
                    minHeight: 25,
                    minWidth: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
