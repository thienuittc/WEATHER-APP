import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../core/utils/text_style_utils.dart';

class LoadingDialogUtils {
  static SimpleFontelicoProgressDialog? _progressDialog;

  /// show loading and return the dialog
  static void showLoading({
    String message = 'loading',
  }) {
    if (_progressDialog != null) return;
    _progressDialog = SimpleFontelicoProgressDialog(
        context: Get.overlayContext!, barrierDimisable: false);
    _progressDialog!.show(
      message: "",
      hideText: true,
      width: 75.r,
      height: 75.r,
      separation: 30.w,
      textStyle: TextStyleUtils.body,
    );
  }

  static void hideLoading() {
    try {
      _progressDialog!.hide();
      _progressDialog = null;
    } catch (e) {}
  }
}
