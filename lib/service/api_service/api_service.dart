import 'package:dio/dio.dart';

class ApiService {

  final Dio _dio = Dio();

  Future<bool> authRegisterUser(String name, String lastName, String phone, String password, String confirmPassword) async {
    try {
      final response = await _dio.post(
        'https://your-api-url.com/register',
        data: {
          'name': name,
          'lastName': lastName,
          'phone': phone,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        // Успешная регистрация
        print('Пользователь успешно зарегистрирован');
        return true;
      } else {
        // Обрабатывать неожиданные коды состояния
        print('Неожиданный код состояния: ${response.statusCode}');
        return false;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Сервер ответил кодом состояния ошибки
        if (e.response!.statusCode == 403) {
          // Обрабатывать определенный код состояния (например, запрещено)
          print('Forbidden: ${e.response!.data}');
        } else {
          // Обрабатывать другие ошибки сервера
          print('Server Error: ${e.response!.statusCode}');
          print('Error Data: ${e.response!.data}');
        }
      } else {
        // Что-то пошло не так с запросом
        print('Request Error: $e');
      }
      return false;
    } catch (e) {
      // Обрабатывать другие исключения
      print('Unexpected Error: $e');
      return false;
    }
  }}