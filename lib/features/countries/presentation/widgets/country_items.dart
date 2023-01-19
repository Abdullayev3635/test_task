import 'package:flutter/material.dart';
import '../../../../core/utils/app_constants.dart';

import '../../domain/entities/country_entity.dart';

class CountryItems extends StatelessWidget {
  final List<CountryEntity> list;

  const CountryItems({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            decoration: const BoxDecoration(
                color: cWhiteColor,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.only(left: 25),
            height: 90,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width-100,
                        child: Text(
                          '${list[index].name}',
                          style:
                              const TextStyle(fontSize: 18, color: cBlackColor),
                        ),
                      ),
                      Text(
                        '${list[index].currency}',
                        style:
                            const TextStyle(fontSize: 15, color: cBlackColor),
                      ),
                      Text(
                        '${list[index].emoji}',
                        style:
                            const TextStyle(fontSize: 22, color: cBlackColor),
                      ),
                    ],
                  ),
                  Text(
                    '${list[index].code}',
                    style: const TextStyle(fontSize: 20, color: cBlackColor),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
