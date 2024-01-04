import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Orders",
            style: TextStyle(
                color: Colors.green,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            tabs: [
              SizedBox(
                height: 40,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("New")]),
              ),
              SizedBox(
                height: 40,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Ongoing")]),
              ),
              SizedBox(
                height: 40,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("History")]),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [Text("hi"), Text("hello"), Text("hello")],
        ),
      ),
    );
  }
}
