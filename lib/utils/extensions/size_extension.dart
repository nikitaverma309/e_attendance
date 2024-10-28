
import 'package:online/utils/extensions/screen_size_util.dart';

extension SizeExtension on num {
  double get sw => ScreenSizeUtil.screenWidth * this;

  double get sh => ScreenSizeUtil.screenHeight * this;
}
