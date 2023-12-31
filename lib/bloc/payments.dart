import 'package:flutter/material.dart';
import 'package:shell/constants/http_client_request_types.dart';
import 'package:shell/helpers/event_bus/main.dart';
import 'package:shell/helpers/http_client.dart';
import 'package:shell/repositories/bloc.dart';
import 'package:transfer/models/payment.dart';

class PaymentsBloc extends AppBlocRepository<Null, List<PaymentBM>> {
  PaymentsBloc() {
    EventBus().subscribe("payment.add", paymentAddListener);
  }

  void paymentAddListener(dynamic data) {
    print("Payment Catched : ${data}");
    call();
  }

  @override
  Future process(String lastRequestUniqueId) async {
    final response = await AppHttpClient().call(
      type: AppHttpClientRequestType.get,
      url: "/transfer",
    );
    if (response?.data != null) {
      fetcherSink(
        response!.data!.map((e) => PaymentBM.fromJson(e)).toList().cast<PaymentBM>(),
        lastRequestUniqueId: lastRequestUniqueId,
      );
    }
  }

  @override
  dispose() {
    EventBus().unSubscribe("payment.add", paymentAddListener);
    return super.dispose();
  }
}

final PaymentsBloc paymentsBloc = PaymentsBloc();
