import 'package:counter/bloc/didierboelens/bloc_provider.dart';
import 'package:counter/bloc/didierboelens/bloc_stream_builder.dart';
import 'package:counter/model/ColorPalette.dart';
import 'package:counter/model/CounterModel.dart';
import 'package:counter/pages/details/single_bloc.dart';
import 'package:counter/pages/details/single_state.dart';
import 'package:flutter/material.dart';

import 'details_of.dart';

class DetailsPage extends StatelessWidget {
  static const route = "/details";

  @override
  Widget build(BuildContext context) {
    final CounterItem counter = ModalRoute.of(context).settings.arguments;
    final DetailsBloc singleBloc = BlocProvider.of<DetailsBloc>(context);

    singleBloc.load(counter);

    return BlocStreamBuilder<DetailsState>(
      bloc: singleBloc,
      builder: (context, state) {
        if (state.isLoading) return Center(child: CircularProgressIndicator());

        return Scaffold(
          body: DetailsOf(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorPalette.color(state?.counter?.colorIndex ?? counter.colorIndex),
            child: Icon(Icons.save),
            onPressed: () => singleBloc.update(),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => singleBloc.backPressed(),
                ),
                IconButton(
                  icon: Icon(Icons.show_chart),
                  tooltip: "History",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
