import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yandex_map/service/api_service/api_service.dart';

part 'auth_register_event.dart';
part 'auth_register_state.dart';

class AuthRegisterBloc extends Bloc<AuthRegisterEvent, AuthRegisterState> {
  ApiService apiService = ApiService();
  AuthRegisterBloc() : super(AuthRegisterInitial()) {
    on<AuthRegisterEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SignUpButtonPressedEvent>((event, emit) async {
      emit(AuthRegisterLoadingState());
      try {
        bool registerSuccess = await apiService.authRegisterUser(event.name, event.lastName, event.phone, event.password, event.confirmPassword);
        if (registerSuccess) {
          emit(AuthRegisterSuccessState(message: 'Пользователь успешно зарегистрирован', accessToken: ''));
        } else {
          emit(AuthRegisterErrorState(errorMessage: 'Ошибка при регистрации'));
        }
      } catch (e) {
        emit(AuthRegisterErrorState(errorMessage: 'Unexpected Error: $e'));
      }
    });
  }
}
