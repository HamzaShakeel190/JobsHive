import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

import '../../widgets/snackbar.dart';
import '../../widgets/user_model.dart';
import 'bloc/sign_up_complete_account_bloc.dart';
import 'models/sign_up_complete_account_model.dart';
import 'package:job_search/core/app_export.dart';
import 'package:job_search/core/utils/validation_functions.dart';
import 'package:job_search/widgets/custom_button.dart';
import 'package:job_search/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore_for_file: must_be_immutable
class SignUpCompleteAccountScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<SignUpCompleteAccountBloc>(
        create: (context) => SignUpCompleteAccountBloc(
            SignUpCompleteAccountState(
                signUpCompleteAccountModelObj: SignUpCompleteAccountModel()))
          ..add(SignUpCompleteAccountInitialEvent()),
        child: SignUpCompleteAccountScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA70002,
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Container(
                      width: double.maxFinite,
                      padding:
                          getPadding(left: 24, top: 13, right: 24, bottom: 13),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomImageView(
                                svgPath: ImageConstant.imgGroup162799,
                                height: getSize(24),
                                width: getSize(24)),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                    padding: getPadding(top: 47, right: 15),
                                    child: Text("Complete Your Account",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtPlusJakartaSansBold24
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.12))))),
                            Padding(
                                padding: getPadding(top: 33),
                                child: Text("First Name",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle
                                        .txtPlusJakartaSansMedium14Bluegray900
                                        .copyWith(
                                            letterSpacing:
                                                getHorizontalSize(0.07)))),
                            BlocSelector<
                                    SignUpCompleteAccountBloc,
                                    SignUpCompleteAccountState,
                                    TextEditingController?>(
                                selector: (state) => state.firstnameController,
                                builder: (context, firstnameController) {
                                  return CustomTextFormField(
                                      focusNode: FocusNode(),
                                      controller: firstnameController,
                                      hintText: "Enter Your First Name",
                                      margin: getMargin(top: 9),
                                      padding: TextFormFieldPadding.PaddingT15,
                                      validator: (value) {
                                        if (!isText(value)) {
                                          return "Please enter valid text";
                                        }
                                        return null;
                                      });
                                }),
                            Padding(
                                padding: getPadding(top: 18),
                                child: Text("Last Name",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle
                                        .txtPlusJakartaSansMedium14Bluegray900
                                        .copyWith(
                                            letterSpacing:
                                                getHorizontalSize(0.07)))),
                            BlocSelector<
                                    SignUpCompleteAccountBloc,
                                    SignUpCompleteAccountState,
                                    TextEditingController?>(
                                selector: (state) => state.lastnameController,
                                builder: (context, lastnameController) {
                                  return CustomTextFormField(
                                      focusNode: FocusNode(),
                                      controller: lastnameController,
                                      hintText: "Enter Your Last Name",
                                      margin: getMargin(top: 9),
                                      padding: TextFormFieldPadding.PaddingT15,
                                      validator: (value) {
                                        if (!isText(value)) {
                                          return "Please enter valid text";
                                        }
                                        return null;
                                      });
                                }),
                            Padding(
                                padding: getPadding(top: 18),
                                child: Text("Email",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle
                                        .txtPlusJakartaSansMedium14Bluegray900
                                        .copyWith(
                                            letterSpacing:
                                                getHorizontalSize(0.07)))),
                            BlocSelector<
                                    SignUpCompleteAccountBloc,
                                    SignUpCompleteAccountState,
                                    TextEditingController?>(
                                selector: (state) => state.emailController,
                                builder: (context, emailController) {
                                  return CustomTextFormField(
                                      focusNode: FocusNode(),
                                      controller: emailController,
                                      hintText: "Enter Your Email",
                                      margin: getMargin(top: 9),
                                      padding: TextFormFieldPadding.PaddingT15,
                                      validator: (value) {
                                        if (!isValidEmail(value,
                                            isRequired: true)) {
                                          return "Please enter valid email";
                                        }
                                        return null;
                                      });
                                }),
                            Padding(
                                padding: getPadding(top: 18),
                                child: Text("Password",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle
                                        .txtPlusJakartaSansMedium14Bluegray900
                                        .copyWith(
                                            letterSpacing:
                                                getHorizontalSize(0.07)))),
                            BlocBuilder<SignUpCompleteAccountBloc,
                                    SignUpCompleteAccountState>(
                                builder: (context, state) {
                              return CustomTextFormField(
                                  focusNode: FocusNode(),
                                  controller: state.passwordController,
                                  hintText: "Create Your Password",
                                  margin: getMargin(top: 9),
                                  padding: TextFormFieldPadding.PaddingT15_1,
                                  textInputAction: TextInputAction.done,
                                  textInputType: TextInputType.visiblePassword,
                                  suffix: InkWell(
                                      onTap: () {
                                        context
                                            .read<SignUpCompleteAccountBloc>()
                                            .add(ChangePasswordVisibilityEvent(
                                                value: !state.isShowPassword));
                                      },
                                      child: Container(
                                          margin: getMargin(
                                              left: 30,
                                              top: 14,
                                              right: 16,
                                              bottom: 14),
                                          child: CustomImageView(
                                              svgPath: state.isShowPassword
                                                  ? ImageConstant.imgEye
                                                  : ImageConstant.imgEye))),
                                  suffixConstraints: BoxConstraints(
                                      maxHeight: getVerticalSize(52)),
                                  validator: (value) {
                                    if (value == null ||
                                        (!isValidPassword(value,
                                            isRequired: true))) {
                                      return "Please enter valid password";
                                    }
                                    return null;
                                  },
                                  isObscureText: state.isShowPassword);
                            }),
                            GestureDetector(
                              onTap: () {
                                onSelectCountry(context);
                              },
                              child: Container(
                                  margin: getMargin(top: 16),
                                  padding: getPadding(
                                      left: 16, top: 12, right: 16, bottom: 12),
                                  decoration: AppDecoration.outlineIndigo50
                                      .copyWith(
                                          borderRadius: BorderRadiusStyle
                                              .roundedBorder24),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                            padding: getPadding(top: 5),
                                            child: Text("Country",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtPlusJakartaSansMedium16
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.08)))),
                                        CustomImageView(
                                            svgPath:
                                                ImageConstant.imgArrowright,
                                            height: getSize(24),
                                            width: getSize(24),
                                            margin:
                                                getMargin(top: 1, bottom: 1))
                                      ])),
                            ),
                            CustomButton(
                                height: getVerticalSize(56),
                                text: "Continue with Email",
                                margin: getMargin(top: 40),
                                variant: ButtonVariant.FillGray900,
                                shape: ButtonShape.RoundedBorder24,
                                padding: ButtonPadding.PaddingAll17,
                                fontStyle: ButtonFontStyle
                                    .PlusJakartaSansSemiBold16Gray50,
                                onTap: () {
                                  signUpWithEmailPassword(context);
                                }),
                            Align(
                                alignment: Alignment.center,
                                child: Padding(
                                    padding: getPadding(
                                        left: 40, top: 28, right: 40),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Already have an account?",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtPlusJakartaSansSemiBold16
                                                  .copyWith(
                                                      letterSpacing:
                                                          getHorizontalSize(
                                                              0.08))),
                                          GestureDetector(
                                              onTap: () {
                                                onBackPressed(context);
                                              },
                                              child: Padding(
                                                  padding: getPadding(left: 3),
                                                  child: Text("Log in",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .txtPlusJakartaSansSemiBold16Gray900
                                                          .copyWith(
                                                              letterSpacing:
                                                                  getHorizontalSize(
                                                                      0.08)))))
                                        ]))),
                            Align(
                                alignment: Alignment.center,
                                child: Container(
                                    width: getHorizontalSize(245),
                                    margin: getMargin(
                                        left: 40,
                                        top: 19,
                                        right: 40,
                                        bottom: 5),
                                    child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text:
                                                  "by creating an account, you agree to our",
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.blueGray400,
                                                  fontSize: getFontSize(14),
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing:
                                                      getHorizontalSize(0.07))),
                                          TextSpan(
                                              text: " terms of service",
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.gray90001,
                                                  fontSize: getFontSize(14),
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing:
                                                      getHorizontalSize(0.07))),
                                          TextSpan(
                                              text: " and",
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.blueGray400,
                                                  fontSize: getFontSize(14),
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing:
                                                      getHorizontalSize(0.07))),
                                          TextSpan(
                                              text: "privacy policy",
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.gray90001,
                                                  fontSize: getFontSize(14),
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing:
                                                      getHorizontalSize(0.07)))
                                        ]),
                                        textAlign: TextAlign.center)))
                          ]))),
            )));
  }

  onTapContinueButton(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<SignUpCompleteAccountBloc>().add(
            CreateRegisterEvent(
              onCreateRegisterEventSuccess: () {
                _onCreateRegisterEventSuccess(context);
              },
              onCreateRegisterEventError: () {
                _onCreateRegisterEventError(context);
              },
            ),
          );
    }
  }

  void _onCreateRegisterEventSuccess(BuildContext context) {
    NavigatorService.pushNamedAndRemoveUntil(
      AppRoutes.loginScreen,
    );
  }

  void _onCreateRegisterEventError(BuildContext context) {
    Fluttertoast.showToast(
      msg: context.read<SignUpCompleteAccountBloc>().postRegisterResp.message ??
          "",
    );
  }

  onBackPressed(BuildContext context) {
    NavigatorService.goBack();
  }

  onSelectCountry(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.selectACountryScreen);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  // sign in user with google account and get user's google drive access and save user data to firestore
  Future signInWithGoogle(BuildContext context) async {
    try {
      final googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      CustomSnackBar.showSnackBar(
        context: context,
        message: 'Signing in...',
        duration: const Duration(seconds: 1),
      );

      User? firebaseUser =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;

      if (firebaseUser != null) {
        // Check is already sign up
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: _auth.currentUser!.uid)
            .get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.isEmpty) {
          // Update data to server if new user
          await addUserFireStore(context);
          CustomSnackBar.showSnackBar(
            context: context,
            message:
                'Successfully signed in, Welcome to SMS Receipt ${user.displayName} 😊❤️',
            duration: const Duration(seconds: 4),
          );
        } else {
          CustomSnackBar.showSnackBar(
            context: context,
            message: 'Welcom back ${user.displayName}',
          );
        }
      } else {
        CustomSnackBar.showSnackBarError(
          context: context,
          message: 'Failed to sign in with Google',
        );
      }
    } catch (error) {
      print("error ---> $error");
      CustomSnackBar.showSnackBarError(
        context: context,
        message: 'Failed to sign in with Google: $error',
      );
    }
  }

  // signup with email and password
  Future signUpWithEmailPassword(BuildContext context) async {
    try {
      final email = context
          .read<SignUpCompleteAccountBloc>()
          .state
          .emailController!
          .text
          .trim();
      final password = context
          .read<SignUpCompleteAccountBloc>()
          .state
          .passwordController!
          .text
          .trim();

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await addUserFireStore(context);

      CustomSnackBar.showSnackBar(
        context: context,
        message: 'Successfully signed up with email and password',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomSnackBar.showSnackBarError(
          context: context,
          message: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        CustomSnackBar.showSnackBarError(
          context: context,
          message: 'The account already exists for that email.',
        );
      }
    } catch (e) {
      print(e);
      CustomSnackBar.showSnackBarError(
        context: context,
        message: 'Failed to sign up with email and password',
      );
    }
  }

  // add user data to firestore
  Future addUserFireStore(BuildContext context) async {
    final userCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid);

    DateFormat dateFormat = DateFormat("dd-MMM-yyyy HH:mm:ss");

    DateTime currentDate = dateFormat.parse(dateFormat.format(DateTime.now()));

    UserModel userModel = UserModel(
      id: _auth.currentUser!.uid,
      name: context
          .read<SignUpCompleteAccountBloc>()
          .state
          .emailController!
          .text
          .trim(),
      email: context
          .read<SignUpCompleteAccountBloc>()
          .state
          .emailController!
          .text
          .trim(),
      profilePicture: "",
      created: currentDate,
    );

    Map<String, dynamic> userMap = userModel.toJson();

    // upload user data to firestore
    await userCollection.set(userMap).then((value) {
      CustomSnackBar.showSnackBar(
        context: Get.context!,
        message: 'Welcome to SMS Receipt ${user.displayName}',
      );
    }).catchError((error) {
      CustomSnackBar.showSnackBarError(
        context: Get.context!,
        message: 'Failed to add user: $error',
      );
    });
  }

  // sign out user from every account google, firebase and get storage
  Future logout(BuildContext context) async {
    if (_auth.currentUser != null) {
      // Get.offAll(
      //   () => LoginScreen(),
      //   transition: Transition.fadeIn,
      //   duration: const Duration(milliseconds: 500),
      // );
      await _auth.signOut();
      await _googleSignIn.signOut();
      CustomSnackBar.showSnackBar(
        context: context,
        message: 'Logged out successfully',
      );
    } else {
      CustomSnackBar.showSnackBarError(
        context: context,
        message: 'Error logging out',
      );
    }
  }
}
