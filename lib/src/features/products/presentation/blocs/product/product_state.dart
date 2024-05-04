part of 'product_bloc.dart';

sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class FavoriteToggleSuccess extends ProductState {
  final bool value;

  FavoriteToggleSuccess({required this.value});
}

final class FavoriteToggleLoading extends ProductState {}

final class FavoriteToggleFailed extends ProductState {}
