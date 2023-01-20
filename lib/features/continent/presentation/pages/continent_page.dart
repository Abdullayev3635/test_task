import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uic_task/core/utils/app_constants.dart';
import 'package:uic_task/features/continent/presentation/widgets/app_bar.dart';

import '../../../../di/dependency_injection.dart';
import '../bloc/continent_bloc.dart';
import '../widgets/continent_items.dart';
import '../widgets/continent_shimmer_widget.dart';

class Continent extends StatefulWidget {
  const Continent({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) => di<ContinentBloc>()..add(GetContinentEvent()),
        child: const Continent(),
      );

  @override
  State<Continent> createState() => _ContinentState();
}

class _ContinentState extends State<Continent> {
  late ContinentBloc _continentBloc;

  @override
  void initState() {
    _continentBloc = BlocProvider.of<ContinentBloc>(context);
    super.initState();
  }

  Future _handleRefresh() async {
    return _continentBloc.add(GetContinentEventRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackgroundColor,
      appBar: const MyAppBar(),
      body: BlocBuilder<ContinentBloc, ContinentState>(
        builder: (context, state) {
          if (state is ContinentLoadedSuccess) {
            return RefreshIndicator(
                onRefresh: _handleRefresh,
                child: ContinentItems(list: state.list));
          } else if (state is ContinentLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: ContinentShimmerWidget(),
            );
          } else if (state is ContinentLoadedFailure) {
            return Center(
              child: Text(state.message,
                  style:
                      const TextStyle(fontSize: 20, color: Color(0xff939EB4))),
            );
          }
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: ContinentShimmerWidget(),
          );
        },
      ),
    );
  }
}
