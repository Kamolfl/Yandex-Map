import 'package:flutter/material.dart';
import 'package:yandex_map/ui/screen/sign_up_page.dart';

import '../../generated/l10n.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  String selectedLanguage = 'English';
  List<String> languageOptions = ["O'zbekcha", "Ўзбекча", "Русский"];
  Map<String, String> languageCodes = {"O'zbekcha": "uz", "Ўзбекча": "kr", "Русский": "ru",};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image.asset('assets/images/FindSport-Logo.png'),
                    ),
                    const Spacer(),
                    Image.asset('assets/images/FindSport.png'),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.25,
              // color: Colors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).languages),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.withOpacity(0.1), width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset('assets/images/image 45.png'),
                        ),
                        Text(S.of(context).chooseALanguage, style: const TextStyle(color: Color(0xFF949CA9))),
                        PopupMenuButton(
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onSelected: (String value) {
                              selectedLanguage = languageCodes[value] ?? 'en';
                              S.load(Locale(selectedLanguage));
                              print('Selected Language: $value');
                              setState(() {});
                            },
                            itemBuilder: (BuildContext context) {
                              return languageOptions.map((String option) {
                                return PopupMenuItem(
                                    value: option,
                                    child: Text(option));
                              }).toList();
                            })
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: FloatingActionButton(onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpPage()));
                      },
                          shape: const CircleBorder(),
                          backgroundColor: Colors.black,
                          child: const Icon(Icons.arrow_forward, color: Colors.white))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
