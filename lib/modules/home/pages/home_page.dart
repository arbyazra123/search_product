import 'package:percent_indicator/percent_indicator.dart';
import 'package:search_product/modules/home/pages/widgets/dashboard_view.dart';

import '../../../shared/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:search_product/components/primary_text_field.dart';
import 'package:search_product/modules/authentication/bloc/auth_bloc.dart';
import 'package:search_product/modules/home/pages/widgets/product_view.dart';
import 'package:search_product/modules/product/detail_product_page.dart';

import '../bloc/product_bloc.dart';

enum ViewMode { dashboard, product }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ViewMode viewMode = ViewMode.dashboard;
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212332),
      appBar: AppBar(
        backgroundColor: Color(0xFF212332),
        title: Text(viewMode.name.toCapitalized()),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LoggedOut());
            },
            icon: Icon(
              Icons.logout,
              color: Colors.red[300]!,
            ),
          )
        ],
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.settings,
            ),
          );
        }),
      ),
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  setState(() {
                    viewMode = ViewMode.dashboard;
                    Navigator.pop(context);
                  });
                },
                title: Text(
                  "Dashboard",
                  style: TextStyle(
                    color: viewMode == ViewMode.dashboard
                        ? Colors.blue
                        : Colors.black,
                  ),
                ),
                trailing: Icon(
                  Icons.dashboard,
                  color: viewMode == ViewMode.dashboard
                      ? Colors.blue
                      : Colors.black,
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    viewMode = ViewMode.product;
                    Navigator.pop(context);
                  });
                },
                title: Text(
                  "Product",
                  style: TextStyle(
                    color: viewMode == ViewMode.product
                        ? Colors.blue
                        : Colors.black,
                  ),
                ),
                trailing: Icon(
                  Icons.calendar_today_outlined,
                  color: viewMode == ViewMode.product
                        ? Colors.blue
                        : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Visibility(
        visible: viewMode == ViewMode.product,
        replacement: DashboardView(),
        child: ProductView(),
      ),
    );
  }
}
