import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitchen_manager/data/models/stock_model.dart';
import 'package:kitchen_manager/data/repositories/firebase_repository.dart';
import 'package:meta/meta.dart';

part 'stock_state.dart';

class StockCubit extends Cubit<StockState> {
  final Repository _repository;
  StockCubit(this._repository) : super(StockInitial());
  void addStock(String? name, int? quantity, int? price) async {
    emit(AddstockLoading());
    try {
      DocumentReference result = await _repository
          .addStock(StockModel(name: name, price: price, quantity: quantity));
      emit(AddStockSuceess());
    } catch (e) {
      emit(AddStockFailure(e.toString()));
    }
  }

  void updateStock(String docID, StockModel updateData) async {
    try {
      emit(UpdateStockLoading());
      await _repository.updateStock(docID, updateData);
      emit(UpdateStockSucess());
    } catch (e) {
      emit(UpdateStockfailure(e.toString()));
    }
  }

  getStockData() async {
    try {
      emit(StockDataLoading());
      List<StockModel> result = await _repository.getStock();
      emit(StockDataSucess(result));
    } catch (e) {
      emit(StockDataFailure(e.toString()));
    }
  }

  deleteStock(String docID) async {
    try {
      emit(DeleteStockLoading());
      await _repository.deletestock(docID);
      emit(DeleteStockSucess());
    } catch (e) {
      emit(DeleteStockfailure(e.toString()));
    }
  }
}
