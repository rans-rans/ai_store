part of 'brand_bloc.dart';

sealed class BrandState {}

final class BrandInitial extends BrandState {}

final class BrandsFetchLoading extends BrandState {}

final class BrandsFetchFailed extends BrandState {}

final class BrandsFetchSuccess extends BrandState {
  final List<Brand> brands;

  BrandsFetchSuccess({required this.brands});
}
