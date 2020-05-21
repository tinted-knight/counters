import 'package:counter/bloc/didierboelens/bloc_navigator.dart';
import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/pages/details/single_bloc.dart';
import 'package:counter/pages/details/single_state.dart';
import 'package:counter/widgets/debug_error_message.dart';
import 'package:flutter/material.dart';

import 'details_of.dart';

class DetailsPage extends StatelessWidget {
  static const route = "/details";

  @override
  Widget build(BuildContext context) {
    final CounterItem counter = ModalRoute.of(context).settings.arguments;
    final DetailsBloc detailsBloc = BlocProvider.of<DetailsBloc>(context);
    final NavigatorBloc navBloc = BlocProvider.of<NavigatorBloc>(context);

    detailsBloc.load(counter);

    return BlocStreamBuilder<DetailsState>(
      bloc: detailsBloc,
      builder: (context, state) {
        if (state is DetailsStateLoading) return Center(child: CircularProgressIndicator());

        if (state is DetailsStateLoaded) return stateLoaded(detailsBloc, state, counter, navBloc);

        return YouShouldNotSeeThis();

        //!deprecated
//        return WillPopScope(
//          onWillPop: () async {
//            detailsBloc.backPressed();
//            return false;
//          },
//          child: stateLoaded(detailsBloc, state, counter, navBloc),
//        );
      },
    );
  }

  Widget stateLoaded(DetailsBloc detailsBloc, DetailsStateLoaded state, CounterItem counter,
          NavigatorBloc navBloc) =>
      Scaffold(
        body: DetailsOf(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: state.counter.colorValue ?? counter.colorValue,
          child: Icon(Icons.save),
          onPressed: () => detailsBloc.update(),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => detailsBloc.backPressed(),
              ),
              IconButton(
                icon: Icon(Icons.show_chart),
                tooltip: "History",
                onPressed: () => navBloc.statOf(counter),
              ),
            ],
          ),
        ),
      );
}
