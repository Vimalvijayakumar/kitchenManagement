import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_manager/data/repositories/firebase_repository.dart';
import 'package:kitchen_manager/ui/common_widgets/app_loader.dart';
import 'package:kitchen_manager/ui/screens/stock/addORupdate_stock.dart';
import 'package:kitchen_manager/ui/screens/stock/stock_cubit.dart';
import 'package:kitchen_manager/utils/colors.dart';
import 'package:kitchen_manager/utils/validaions.dart';
import 'package:sizer/sizer.dart';

class StockList extends StatefulWidget {
  const StockList({super.key});

  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  @override
  void initState() {
    BlocProvider.of<StockCubit>(context).getStockData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.backgroundColor2,
      appBar: AppBar(
        backgroundColor: Appcolors.backgroundColor,
        title: Text("Stock List"),
      ),
      body: BlocConsumer<StockCubit, StockState>(
        listener: (context, state) {
          if (state is StockDataFailure) {
            AppValidations.showToast(state.error.toString());
          }
        },
        builder: (context, state) {
          if (state is StockDataLoading) {
            return AppLoader();
          }
          if (state is StockDataSucess) {
            var data = state.stockData;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          data[index].name.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Container(
                          padding: EdgeInsets.only(top: 5),
                          width: 100.w,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Price",
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      data[index].price.toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Qty (Kg)"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data[index].quantity.toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                          create: (context) =>
                                              StockCubit(Repository()),
                                          child:
                                              AddStock(stockdata: data[index]),
                                        )));
                          },
                          child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Icon(
                                Icons.edit,
                                size: 18,
                                color: Appcolors.accentColor,
                              )),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BlocProvider(
                        create: (context) => StockCubit(Repository()),
                        child: AddStock(),
                      )));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
