import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restapi_bloc/models/user_model.dart';

@immutable
abstract class UserState extends Equatable {}

//Data loading state
class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  UserLoadedState(this.users);

  final List<UserModel> users;

  @override
  List<Object?> get props => [users];
}

class UserErrorState extends UserState {
  UserErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
