part of 'detail_product_bloc.dart';

abstract class DetailProductEvent extends Equatable {
  const DetailProductEvent();

  @override
  List<Object> get props => [];
}

class GetDetailProduct extends DetailProductEvent {
  final String id;

  const GetDetailProduct(this.id);

  @override
  List<Object> get props => [id];
}
