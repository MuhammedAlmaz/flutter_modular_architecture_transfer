import 'package:flutter/material.dart';
import 'package:shell/components/container.dart';
import 'package:shell/helpers/event_bus/main.dart';
import 'package:transfer/bloc/payments.dart';
import 'package:transfer/models/payment.dart';

class TransfersScreen extends StatefulWidget {
  const TransfersScreen({Key? key}) : super(key: key);

  @override
  State<TransfersScreen> createState() => _TransfersScreenState();
}

class _TransfersScreenState extends State<TransfersScreen> {
  @override
  void initState() {
    paymentsBloc.call();
    super.initState();
  }


  Widget _renderPayment(int index) {
    PaymentBM payment = paymentsBloc.store![index];
    return Row(
      children: [
        Text("${payment.price} -> "),
        Expanded(
          child: Text(
            payment.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget get _content {
    if (paymentsBloc.isBlocHandling) return Text("Loading....");
    if ((paymentsBloc.store ?? []).isEmpty) return Text("Empty Data");
    return ListView.builder(
      itemCount: paymentsBloc.store!.length,
      itemBuilder: (_, index) => _renderPayment(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      title: "Transfer Team Project",
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: StreamBuilder(builder: (_, __) => _content, stream: paymentsBloc.stream),
      ),
    );
  }
}
