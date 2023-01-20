import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uic_task/core/utils/app_constants.dart';
import 'package:uic_task/features/countries/presentation/bloc/country_bloc.dart';
import 'package:uic_task/features/countries/presentation/widgets/app_bar.dart';

import '../../../../di/dependency_injection.dart';
import '../widgets/country_items.dart';
import '../widgets/country_shimmer_widget.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({Key? key, required this.code, required this.name})
      : super(key: key);
  final String code;
  final String name;

  static Widget screen(String code, String name) => BlocProvider(
        create: (context) =>
            di<CountryBloc>()..add(GetCountryEvent(page: 1, code: code)),
        child: CountryPage(
          code: code,
          name: name,
        ),
      );

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  late CountryBloc _countryBloc;

  @override
  void initState() {
    _countryBloc = BlocProvider.of<CountryBloc>(context);
    super.initState();
  }

  Future _handleRefresh(String code) async {
    return _countryBloc.add(GetCountryEvent(page: 1, code: code));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackgroundColor,
      appBar: MyAppBar(
        name: widget.name,
      ),
      body: BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) {
          if (state is CountryLoadedSuccess) {
            return RefreshIndicator(
                onRefresh: () => _handleRefresh(widget.code),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18, right: 18, bottom: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: cWhiteColor,
                          boxShadow: const [
                            BoxShadow(color: cBackgroundColor, blurRadius: 40)
                          ],
                        ),
                        height: 65,
                        margin: const EdgeInsets.only(top: 27),
                        padding: const EdgeInsets.fromLTRB(13, 2, 0, 0),
                        child: Center(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: cBlackColor,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.top,
                                  cursorColor: cBlackColor,
                                  cursorHeight: 17,
                                  onChanged: (value) {
                                    _countryBloc
                                        .add(SearchCountryEvent(text: value));
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(bottom: 0),
                                    hintText: "Search",
                                    hintStyle: TextStyle(
                                        fontSize: 14, color: Colors.black26),
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
                      ),
                    ),
                    Expanded(child: CountryItems(list: state.list, bloc: _countryBloc)),
                  ],
                ));
          } else if (state is CountryLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: CountryShimmerWidget(),
            );
          } else if (state is CountryLoadedFailure) {
            return Center(
              child: Text(state.message,
                  style:
                      const TextStyle(fontSize: 20, color: Color(0xff939EB4))),
            );
          }
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: CountryShimmerWidget(),
          );
        },
      ),
    );
  }
}
