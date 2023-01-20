import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../core/utils/app_constants.dart';

import '../../domain/entities/country_entity.dart';
import '../bloc/country_bloc.dart';

class CountryItems extends StatelessWidget {
  final List<CountryEntity> list;
  final CountryBloc bloc;

  const CountryItems({
    Key? key,
    required this.list,
    required this.bloc,
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
            width: MediaQuery.of(context).size.width - 50,
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.only(left: 25),
            height: 90,
            child: SlidableAutoCloseBehavior(
              closeWhenTapped: false,
              child: Slidable(
                key: Key('${list[index].emojiU}'),
                direction: Axis.horizontal,
                endActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const BehindMotion(),
                  dragDismissible: true,
                  children: [
                    InkWell(
                      onTap: () {
                        bloc.add(
                            RemoveCountryEvent(countryEntity: list[index]));
                      },
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(15)),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 70) / 4,
                        height: 167,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(15),
                          ),
                        ),
                        child: const Icon(Icons.delete, color: cWhiteColor),
                      ),
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: cWhiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 150,
                              child: Text(
                                '${list[index].name}',
                                style: const TextStyle(
                                    fontSize: 18, color: cBlackColor),
                              ),
                            ),
                            Text(
                              '${list[index].currency}',
                              style: const TextStyle(
                                  fontSize: 15, color: cBlackColor),
                            ),
                            Text(
                              '${list[index].emoji}',
                              style: const TextStyle(
                                  fontSize: 22, color: cBlackColor),
                            ),
                          ],
                        ),
                        Text(
                          '${list[index].code}',
                          style:
                              const TextStyle(fontSize: 20, color: cBlackColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
