import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../system/_base/model/content/login_model.dart';
// class MainCubit extends Cubit<BuildContext> {
//   MainCubit(BuildContext initialState) : super(initialState);
// }

class LoginCubit extends Cubit<LoginModel> {
  LoginCubit(this._loginModel) : super(LoginModel());

  // ignore: unused_field
  final LoginModel _loginModel;
}
