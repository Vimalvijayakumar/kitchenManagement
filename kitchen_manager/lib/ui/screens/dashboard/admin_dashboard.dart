import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_manager/data/repositories/firebase_repository.dart';
import 'package:kitchen_manager/ui/screens/orders/admin_screen.dart';
import 'package:kitchen_manager/ui/screens/orders/orders_cubit.dart';
import 'package:kitchen_manager/ui/screens/stock/stock.dart';
import 'package:kitchen_manager/ui/screens/stock/stock_cubit.dart';
import 'package:kitchen_manager/utils/colors.dart';
import 'package:sizer/sizer.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.backgroundColor2,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Admin Dashboard",
          style: TextStyle(
              color: Colors.green,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(Icons.logout),
          SizedBox(
            width: 20,
          )
        ],
        elevation: 0,
        backgroundColor: Appcolors.backgroundColor,
        shadowColor: Appcolors.backgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                ButtonBox(
                    title: "Orders",
                    img: "assets/images/food-delivery.png",
                    clickevent: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                        create: (context) =>
                                            OrdersCubit(Repository()),
                                        child: AdminOrdersScreen(),
                                      )))
                        }),
                SizedBox(
                  height: 20,
                ),
                ButtonBox(
                    title: "Stock",
                    img: "assets/images/inventory.png",
                    clickevent: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                        create: (context) =>
                                            StockCubit(Repository()),
                                        child: StockList(),
                                      )))
                        }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonBox extends StatelessWidget {
  final String title;
  final String img;
  final VoidCallback clickevent;
  const ButtonBox({
    super.key,
    required this.title,
    required this.img,
    required this.clickevent,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: clickevent,
      child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              Image.asset(
                img,
                width: 40,
                height: 40,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Appcolors.textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Appcolors.hintColor,
              )
            ],
          )),
    );
  }
}

class ValueBoxes extends StatelessWidget {
  const ValueBoxes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
              color: Color(0xFFBEBEBE),
              offset: Offset(10, 10),
              blurRadius: 30,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-10, -10),
              blurRadius: 30,
              spreadRadius: 1,
            ),
          ],
          color: Colors.white,
          // border: Border.all(color: Colors.green, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.kitchen,
            color: Colors.green,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Orders",
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }
}
