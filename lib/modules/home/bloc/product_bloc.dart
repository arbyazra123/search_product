import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:search_product/modules/home/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<Product>? _results;
  ProductBloc() : super(ProductInitial()) {
    on<GetProducts>(
      (event, emit) async {
        emit(ProductLoading());
        try {
          final response = await Client()
              .get(Uri.parse("https://fakestoreapi.com/products"));
          if (response.statusCode == 200) {
            _results = productFromJson(response.body);
            emit(ProductLoaded(_results!));
          } else {
            emit(ProductError("Ups, sesuatu kesalahan terjadi"));
          }
        } on Exception catch (e) {
          emit(ProductError("Ups, sesuatu kesalahan terjadi"));
        }
      },
    );
    on<SearchProduct>(
      (event, emit) async {
        try {
          debugPrint("event.query ${event.query}");
          if (event.query.isEmpty) {
            emit(ProductLoaded(event.products));
            return;
          }
          var searchRaw = _results;
          var result = searchRaw?.where((element) {
            return element
                .toJson()
                .toString()
                .toLowerCase()
                .contains(event.query.toLowerCase());
          }).toList();
          emit(ProductLoaded(result ?? []));
        } on Exception catch (e) {
          emit(ProductError("Ups, sesuatu kesalahan terjadi"));
        }
      },
    );
  }
}
