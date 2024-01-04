import 'package:bloc/bloc.dart';
import 'package:kitchen_manager/data/repositories/firebase_repository.dart';
import 'package:meta/meta.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final Repository _repository;
  OrdersCubit(this._repository) : super(OrdersInitial());
}
