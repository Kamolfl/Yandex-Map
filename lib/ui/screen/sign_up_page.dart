import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_map/service/api_service/api_service.dart';
import 'package:yandex_map/ui/screen/clubs_ads_add.dart';
import 'package:yandex_map/ui/widgets/sign_up_widgets/sign_up_form_input.dart';
import 'package:yandex_map/ui/widgets/sign_up_widgets/sign_up_phone_number_form_input.dart';
import 'package:yandex_map/ui/widgets/sign_up_widgets/sign_up_save_button.dart';

import '../../bloc/auth_register_bloc/auth_register_bloc.dart';
import '../../generated/l10n.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => AuthRegisterBloc(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Center(
                    child: Image.asset(
                      'assets/images/Frame 18406.png',
                      width: 200,
                      height: 200,
                    )),
                Text(S.of(context).signUp,
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                SignUpFormInput(
                    title: S.of(context).firstName,
                    controller: _nameController,
                    hintText: S.of(context).enterYourFirstName),
                SignUpFormInput(
                    title: S.of(context).lastName,
                    controller: _lastNameController,
                    hintText: S.of(context).enterYourLastName),
                SignUpPhoneNumberFormInput(
                    controller: _phoneNumberController),
                SignUpFormInput(
                    title: S.of(context).password,
                    controller: _passwordController,
                    hintText: S.of(context).enterYourPassword),
                SignUpFormInput(
                    title: S.of(context).confirmPassword,
                    controller: _confirmPasswordController,
                    hintText: S.of(context).enterYourConfirmPassword),
                BlocBuilder<AuthRegisterBloc, AuthRegisterState>(
                  builder: (context, state) {
                    if (state is AuthRegisterLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AuthRegisterSuccessState) {
                      Future.delayed(Duration.zero, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ClubsAdsAdd(),
                        ));
                      });
                    } else if (state is AuthRegisterErrorState) {
                      return Text(state.errorMessage);
                    }
                    return SignUpButton(onPressed: () async {
                      if (_nameController.text.isEmpty ||
                          _lastNameController.text.isEmpty ||
                          _phoneNumberController.text.isEmpty ||
                          _passwordController.text.isEmpty ||
                          _confirmPasswordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(S.of(context).allFieldsMustBeFilledIn),
                          ),
                        );
                      } else if (_passwordController.text.trim() !=
                          _confirmPasswordController.text.trim()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(S.of(context).passwordsAreDifferent),
                          ),
                        );
                      } else {
                        BlocProvider.of<AuthRegisterBloc>(context)
                            .add(SignUpButtonPressedEvent(
                          name: _nameController.text.trim(),
                          lastName: _lastNameController.text.trim(),
                          phone: '+998 ${_phoneNumberController.text.trim()}',
                          password: _passwordController.text.trim(),
                          confirmPassword: _confirmPasswordController.text.trim(),
                        ));
                      }
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
