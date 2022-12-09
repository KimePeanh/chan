import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:lady_skin/src/features/my_order/models/my_order.dart';
import 'package:lady_skin/src/features/my_order/repositories/my_order_respository.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';
import 'my_order_event.dart';
import 'my_order_state.dart';

class MyOrderBloc extends Bloc<MyOrderEvent, MyOrderState> {
  List<MyOrder> orderList = [];
  late MyOrderDetail orderHistoryDetail;
  final OrderRepository? orderRepository;
  @override
  MyOrderBloc({required this.orderRepository}) : super(FetchingOrder());

  @override
  Stream<MyOrderState> mapEventToState(MyOrderEvent event) async* {
    if (event is FetchMyOrder) {
      yield FetchingOrder();
      try {
        orderList = await orderRepository!.getOrderList();
        yield FetchedOrder();
      } catch (e) {
        yield ErrorFetchingOrder(error: e);
      }
    }
    if (event is FetchMyOrderDetail) {
      yield FetchingOrder();
      try {
        orderHistoryDetail = await getOrderDetail(orderId: event.orderId);
        yield FetchedOrder();
      } catch (e) {
        yield ErrorFetchingOrder(error: e);
      }
    }
    if (event is PayOrder) {
      yield PayingOrder();
      try {
        final String _imageUrl =
            await uploadImage(image: event.transactionImage);
        await payOrder(
            imageUrl: _imageUrl,
            orderId: event.orderId,
            paymentMethod: event.paymentMethod);
        //orderList = await orderRepository.getOrderList();
        yield PaidOrder();
      } catch (e) {
        yield ErrorPayingOrder(error: e);
      }
    }
  }
}

// MyOrderBloc orderHistoryBloc;
