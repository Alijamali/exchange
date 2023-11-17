import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Data/models/ResponseModel.dart';
import '../../../Data/models/user/UserModel.dart';

import '../../../Logic/provider/language_provider.dart';
import '../../../Logic/provider/user_data_provider.dart';
import '../main_wrapper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  late UserDataProvider userProvider;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserDataProvider>(context);
    final languageProvider = Provider.of<ChangeLanguageProvider>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                textDirection: languageProvider.languageCode == 'en' ? TextDirection.ltr : TextDirection.rtl,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 30,),
                  Lottie.asset('assets/images/anim_lottie/waveloop.json', height: height * 0.2, width: double.infinity, fit: BoxFit.fill),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'sign_up'.tr,
                      style:
                          GoogleFonts.ubuntu(fontSize: height * 0.030, color: Theme.of(context).unselectedWidgetColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text('create_account'.tr,
                        style: GoogleFonts.ubuntu(fontSize: height * 0.025, color: Theme.of(context).unselectedWidgetColor)),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person,
                              ),
                              hintText: 'username'.tr,
                              hintStyle: GoogleFonts.ubuntu(color: Theme.of(context).unselectedWidgetColor),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.amberAccent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            style: GoogleFonts.ubuntu(color: Theme.of(context).unselectedWidgetColor),
                            controller: nameController,
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter username';
                              } else if (value.length < 4) {
                                return 'at least enter 4 characters';
                              } else if (value.length > 13) {
                                return 'maximum character is 13';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email_rounded),
                              hintText: 'gmail'.tr,
                              hintStyle: GoogleFonts.ubuntu(color: Theme.of(context).unselectedWidgetColor),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.amberAccent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            style: GoogleFonts.ubuntu(color: Theme.of(context).unselectedWidgetColor),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter gmail';
                              } else if (!value.endsWith('@gmail.com')) {
                                return 'please enter valid gmail';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_open),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure ? Icons.visibility : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                              hintText: 'password'.tr,
                              hintStyle: GoogleFonts.ubuntu(color: Theme.of(context).unselectedWidgetColor),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.amberAccent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            style: GoogleFonts.ubuntu(color: Theme.of(context).unselectedWidgetColor),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              } else if (value.length < 7) {
                                return 'at least enter 6 characters';
                              } else if (value.length > 13) {
                                return 'maximum character is 13';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Text(
                            'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                            style: textTheme.titleSmall,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Consumer<UserDataProvider>(builder: (context, userDataProvider, child) {
                            switch (userDataProvider.registerStatus?.status) {
                              case Status.LOADING:
                                return const CircularProgressIndicator();
                              case Status.COMPLETED:
                                savedLogin(userDataProvider.registerStatus?.data);
                                WidgetsBinding.instance.addPostFrameCallback(
                                    (timeStamp) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainWrapper())));
                                return signupBtn();
                              case Status.ERROR:
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    signupBtn(),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.error,
                                          color: Colors.redAccent,
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          userDataProvider.registerStatus!.message,
                                          style: GoogleFonts.ubuntu(color: Colors.redAccent, fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              default:
                                return signupBtn();
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Text(
                    'Already have an account?',
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder:  (context) => const LoginScreen()));
                        },
                        child: Text('login'.tr),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget signupBtn() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),


        ),
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            userProvider.callRegisterApi(nameController.text, emailController.text, passwordController.text);
          }
        },
        child: Text('sign_up'.tr),
      ),
    );
  }

  Future<void> savedLogin(UserModel model) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString("user_token", model.token!);
    prefs.setBool("LoggedIn", true);
  }
}
