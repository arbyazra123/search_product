part of 'product_bloc.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class GetProducts extends ProductEvent {
  const GetProducts();

  @override
  List<Object> get props => [];
}

class SearchProduct extends ProductEvent {
  final String query;
  final List<Product> products;

  const SearchProduct(this.query, this.products);
  @override
  List<Object> get props => [query];
}
