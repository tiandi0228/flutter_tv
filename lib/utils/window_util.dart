import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowUtil {
  // 初始化
  static void init(double width, double height) async {
    WidgetsFlutterBinding.ensureInitialized();
    // 必须加上这一行。
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = WindowOptions(
      size: Size(width, height),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  // 设置用户是否可以手动放大缩小
  static void setResizable(bool reSize) {
    windowManager.setResizable(reSize);
  }
}
