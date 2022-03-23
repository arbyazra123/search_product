import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:search_product/components/primary_text_field.dart';
import 'package:search_product/modules/authentication/bloc/auth_bloc.dart';
import 'package:search_product/modules/product/detail_product_page.dart';

import '../bloc/product_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: Icon(Icons.settings),
            );
          })
        ],
      ),
      endDrawerEnableOpenDragGesture: false,
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  context.read<AuthBloc>().add(LoggedOut());
                },
                title: Text(
                  "Logout",
                ),
                trailing: Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductError) {
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async =>
                      context.read<ProductBloc>().add(GetProducts()),
                  child: ListView(),
                ),
                Center(
                  child: Text(state.error),
                ),
              ],
            );
          }
          if (state is ProductLoaded) {
            var result = state.results;
            return Column(
              children: [
                SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PrimaryTextField(
                    labelText: "Search Product",
                    onChanged: (v) {
                      context.read<ProductBloc>().add(SearchProduct(v, result));
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        context.read<ProductBloc>().add(GetProducts()),
                    child: ListView.separated(
                      itemCount: result.length,
                      separatorBuilder: (a, b) => SizedBox(
                        height: 20,
                      ),
                      itemBuilder: (_, index) {
                        var data = result[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (v) =>
                                        DetailProductPage(product: data)));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            padding: EdgeInsets.all(
                              14,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    color: Colors.black.withOpacity(0.08))
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 140,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      data.image ?? "",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.title ?? "-",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Rating ${data.rating?.rate ?? "-"}",
                                        style: TextStyle(),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        data.category ?? "-",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 14,
                                      ),
                                      Text(
                                        NumberFormat.simpleCurrency(
                                                decimalDigits: 0, name: "USD ")
                                            .format(data.price ?? 0),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
