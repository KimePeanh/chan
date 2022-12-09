import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/checkout/bloc/checkout_bloc.dart';
import 'package:lady_skin/src/features/checkout/bloc/checkout_state.dart';
import 'package:lady_skin/src/features/checkout/screens/widgets/status_card.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';

class CheckoutStatusPage extends StatefulWidget {
  @override
  _CheckoutStatusPageState createState() => _CheckoutStatusPageState();
}

class _CheckoutStatusPageState extends State<CheckoutStatusPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        // Helper.handleState(state: state, context: context);
        // return StatusCard(
        //   status: Status.Failed,
        // );
        if (state is CheckedOut) {
          return StatusCard(status: Status.Succes);
        }
        if (state is ErrorCheckingOut) {
          Helper.handleState(state: state, context: context);
          return StatusCard(status: Status.Failed);
        }
        return Scaffold(
          body: Center(
            child: Container(
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            ),
          ),
        );
      },
    );
  }
}
