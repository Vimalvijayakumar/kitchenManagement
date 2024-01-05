import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_manager/data/models/stock_model.dart';
import 'package:kitchen_manager/data/repositories/firebase_repository.dart';
import 'package:kitchen_manager/ui/common_widgets/app_loader.dart';
import 'package:kitchen_manager/ui/screens/stock/stock.dart';
import 'package:kitchen_manager/ui/screens/stock/stock_cubit.dart';
import 'package:kitchen_manager/utils/colors.dart';
import 'package:kitchen_manager/utils/validaions.dart';

class AddStock extends StatefulWidget {
  final StockModel? stockdata;
  const AddStock({super.key, this.stockdata});

  @override
  State<AddStock> createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _qtyController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    var itemData = widget.stockdata;
    if (itemData != null) {
      _nameController.text = itemData.name.toString();
      _priceController.text = itemData.price.toString();
      _qtyController.text = itemData.quantity.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.backgroundColor2,
      appBar: AppBar(
        backgroundColor: Appcolors.backgroundColor,
        title: Text(widget.stockdata == null ? "Add Stock" : "Edit Stock"),
      ),
      body: BlocConsumer<StockCubit, StockState>(
        listener: (context, state) {
          if (state is AddStockSuceess) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider(
                          create: (context) => StockCubit(Repository()),
                          child: StockList(),
                        )));
          }
          if (state is AddStockFailure) {
            AppValidations.showToast(state.error.toString());
          }
          if (state is UpdateStockSucess) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider(
                          create: (context) => StockCubit(Repository()),
                          child: StockList(),
                        )));
          }
          if (state is UpdateStockfailure) {
            AppValidations.showToast(state.error.toString());
          }
          if (state is DeleteStockSucess) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider(
                          create: (context) => StockCubit(Repository()),
                          child: StockList(),
                        )));
          }
          if (state is DeleteStockfailure) {
            AppValidations.showToast(state.error.toString());
          }
        },
        builder: (context, state) {
          if (state is UpdateStockLoading) {
            return AppLoader();
          }
          if (state is AddstockLoading) {
            return AppLoader();
          }
          if (state is DeleteStockLoading) {
            return AppLoader();
          }
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              //icon: const Icon(Icons.person),
                              hintText: 'Enter ingreadient',
                              labelText: 'Ingreadient',
                            ),
                            validator: (value) {
                              if (value == "") {
                                return 'Please enter ingreadient';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]")),
                            ],
                            controller: _qtyController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              //icon: const Icon(Icons.person),
                              hintText: 'Enter quantity',
                              labelText: 'Quantity',
                            ),
                            validator: (value) {
                              if (value == "") {
                                return 'Please enter Quantity';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]*[.]{0,1}")),
                            ],
                            controller: _priceController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              //icon: const Icon(Icons.person),

                              hintText: 'Enter price',
                              labelText: 'Price',
                            ),
                            validator: (value) {
                              if (value == "") {
                                return 'Please enter Price';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          widget.stockdata == null
                              ? SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Appcolors.accentColor),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: BorderSide(
                                                      color: Appcolors
                                                          .accentColor)))),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          BlocProvider.of<StockCubit>(context)
                                              .addStock(
                                                  _nameController.text,
                                                  int.parse(
                                                      _qtyController.text),
                                                  int.parse(
                                                      _priceController.text));
                                        } else {
                                          AppValidations.showToast(
                                              "please fill all fields");
                                        }
                                      },
                                      child: Text(
                                        "ADD",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )))
                              : Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Appcolors
                                                            .backgroundColor),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                        side: BorderSide(
                                                            color: Appcolors
                                                                .accentColor)))),
                                            onPressed: () {
                                              BlocProvider.of<StockCubit>(
                                                      context)
                                                  .deleteStock(widget
                                                      .stockdata!.stockId
                                                      .toString());
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                color: Appcolors.textColor,
                                              ),
                                            ))),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Appcolors.accentColor),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                        side: BorderSide(
                                                            color: Appcolors
                                                                .accentColor)))),
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                BlocProvider.of<StockCubit>(
                                                        context)
                                                    .updateStock(
                                                        widget
                                                            .stockdata!.stockId
                                                            .toString(),
                                                        StockModel(
                                                            name:
                                                                _nameController
                                                                    .text,
                                                            quantity: int.parse(
                                                                _qtyController
                                                                    .text),
                                                            price: int.parse(
                                                                _priceController
                                                                    .text)));
                                              } else {
                                                AppValidations.showToast(
                                                    "please fill all fields");
                                              }
                                            },
                                            child: Text(
                                              "Update",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            )))
                                  ],
                                )
                        ],
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
