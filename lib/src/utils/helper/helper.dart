import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/features/authentication/bloc/index.dart';
import 'package:lady_skin/src/features/cart/bloc/index.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';

class Helper {
  static String convertToKhmerPhoneNumber({required String number}) {
    return number;
  }

  static List<String> convertStringtoListString({required String data}) {
    return json.decode(data);
  }

  static String convertListStringtoString({required List<String> data}) {
    String result = '"["';
    result += data.join('","');
    result += '"]"';
    return result;
  }

  static void requiredLoginFuntion(
      {required BuildContext context, required Function callBack}) {
    if (BlocProvider.of<AuthenticationBloc>(context).state is Authenticated) {
      callBack();
    } else {
      Navigator.pushNamed(context, loginRegister, arguments: true);
    }
  }

  static void imgFromGallery(onPicked(File image)) async {
    final picker = ImagePicker();
    PickedFile imageP =
        (await picker.getImage(source: ImageSource.gallery, imageQuality: 50))!;
    final File image = File(imageP.path);
    onPicked(image);
  }

  static void imgFromCamera(onPicked(File image)) async {
    final picker = ImagePicker();
    PickedFile imageP =
        (await picker.getImage(source: ImageSource.camera, imageQuality: 50))!;
    final File image = File(imageP.path);
    onPicked(image);
  }

  static List<Color> randomGradientColor() {
    List<Color> colorList;
    try {
      colorList =
          _gradientColorList[random.nextInt(_gradientColorList.length - 1)];
    } catch (_) {
      colorList = [Color(0xFF8A2387), Color(0xFFE94057), Color(0xFFF27121)];
    }
    return colorList;
  }

  static handleState(
      {required ErrorState state, required BuildContext context}) {
    if (state.error == 401
        // (state is ErrorCheckingOut && state.error is InvalidTokenException) ||
        //   (state is ErrorFetchingCart && state.error is InvalidTokenException) ||
        //   (state is ErrorCart && state.error is InvalidTokenException) ||
        //   (state is ErrorFetchingAccount &&
        //       state.error is InvalidTokenException) ||
        //   (state is ErrorFetchingBuyNow &&
        //       state.error is InvalidTokenException) ||
        //   (state is ChangeFailed && state.error is InvalidTokenException) ||
        //   (state is ErrorFetchingFavouite &&
        //       state.error is InvalidTokenException) ||
        //   (state is ErrorFavourite && state.error is InvalidTokenException) ||
        //   (state is ErrorFetchingOrder && state.error is InvalidTokenException) ||
        //   (state is ErrorPayingOrder && state.error is InvalidTokenException) ||
        //   (state is ErrorFetchingReviewList &&
        //       state.error is InvalidTokenException) ||
        //   (state is ErrorInitializingReviewList &&
        //       state.error is InvalidTokenException) ||
        //   (state is ErrorAddingReview && state.error is InvalidTokenException) ||
        //   (state is ErrorUpdateReview && state.error is InvalidTokenException) ||
        //   (state is ErrorFetchingAddressList &&
        //       state.error is InvalidTokenException) ||
        //   state is ErrorProcessingAddress &&
        //       state.error is InvalidTokenException ||
        // state is ErrorUpdatingAccount && state.error is InvalidTokenException
        ) {
      BlocProvider.of<AuthenticationBloc>(context).add(LogoutPressed());

      BlocProvider.of<CartBloc>(context).add(LogoutCart());
    } else {
      return;
    }
  }
}

Random random = new Random();
List<List<Color>> _gradientColorList = [
  [Color(0xFF8A2387), Color(0xFFE94057), Color(0xFFF27121)],
  [Color(0xFFbc4e9c), Color(0xFFf80759)],
  [Color(0xFF642B73), Color(0xFFC6426E)],
  [Color(0xFFC33764), Color(0xFF1D2671)],
  [Color(0xFFcb2d3e), Color(0xFFef473a)],
  [Color(0xFFec008c), Color(0xFFec008c)],
  [Color(0xFFf953c6), Color(0xFFb91d73)],
  [Color(0xFF7F00FF), Color(0xFFE100FF)],
  [Color(0xFF8A2387), Color(0xFFE94057), Color(0xFFF27121)],
  [Color(0xFFf12711), Color(0xFFf5af19)]
];
