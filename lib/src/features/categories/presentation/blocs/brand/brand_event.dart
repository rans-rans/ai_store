part of 'brand_bloc.dart';

sealed class BrandEvent {}

final class FetchAllBrandsEvent extends BrandEvent {
  final String token;

  FetchAllBrandsEvent(this.token);
}
