part of 'app_bloc.dart';

abstract class AppEvent {}

class LoadAppData extends AppEvent {}

class AddDonation extends AppEvent {
  final double amount;

  AddDonation(this.amount);
}