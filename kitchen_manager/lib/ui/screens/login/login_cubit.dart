import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitchen_manager/data/repositories/firebase_repository.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Repository _repository;
  LoginCubit(this._repository) : super(LoginInitial());

  void Login(String email, String password) async {
    bool isAdmin;
    emit(LoginLoading());
    try {
      UserCredential userData = await _repository.login(email, password);
      isAdmin = await _repository.chkAdmin(email);
      if (isAdmin) {
        emit(AdminLoginSucess());
      } else {
        emit(ChefLoginSucess());
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
