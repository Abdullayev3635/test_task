import 'package:flutter/material.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../countries/presentation/pages/country_page.dart';
import '../../domain/entities/continent_entity.dart';

class ContinentItems extends StatelessWidget {
  final List<ContinentEntity> list;

  const ContinentItems({
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CountryPage.screen(
                    list[index].code ?? "", list[index].name ?? ""),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
                color: cWhiteColor,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.only(left: 20),
            height: 90,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${list[index].name}',
                style: const TextStyle(fontSize: 20, color: cBlackColor),
              ),
            ),
          ),
        );
      },
    );
  }
}
