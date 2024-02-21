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

  // 设置全屏
  static void setFullScreen(bool fullScreen) {
    windowManager.setFullScreen(fullScreen);
  }

  // 检测当前是否全屏
  static Future<bool> isFullScreen() {
    return windowManager.isFullScreen();
  }

  // 最大化窗口
  static void setMaximize(bool reSize) {
    windowManager.maximize(vertically: reSize);
  }

  // 取消最大化窗口
  static void setUnmaximize() {
    windowManager.unmaximize();
  }

  // 检测当前窗口是否最大化
  static Future<bool> isMaximized() {
    return windowManager.isMaximized();
  }
}
