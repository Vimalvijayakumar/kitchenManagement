part of 'stock_cubit.dart';

@immutable
sealed class StockState {}

final class StockInitial extends StockState {}

class AddstockLoading extends StockState {}

class AddStockSuceess extends StockState {}

class AddStockFailure extends StockState {
  final String error;

  AddStockFailure(this.error);
}

class StockDataLoading extends StockState {}

class StockDataSucess extends StockState {
  final List<StockModel> stockData;

  StockDataSucess(this.stockData);
}

class StockDataFailure extends StockState {
  final String error;

  StockDataFailure(this.error);
}

class UpdateStockLoading extends StockState {}

class UpdateStockSucess extends StockState {}

class UpdateStockfailure extends StockState {
  final String error;

  UpdateStockfailure(this.error);
}

class DeleteStockLoading extends StockState {}

class DeleteStockSucess extends StockState {}

class DeleteStockfailure extends StockState {
  final String error;

  DeleteStockfailure(this.error);
}
