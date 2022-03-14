import 'package:get/get.dart';

import '../modules/chatbox/bindings/chatbox_binding.dart';
import '../modules/chatbox/views/chatbox_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/ma_course/bindings/ma_course_binding.dart';
import '../modules/ma_course/views/ma_course_view.dart';
import '../modules/map_course/bindings/map_course_binding.dart';
import '../modules/map_course/views/map_course_view.dart';
import '../modules/note/bindings/note_binding.dart';
import '../modules/note/views/note_view.dart';
import '../modules/recherche/bindings/recherche_binding.dart';
import '../modules/recherche/views/recherche_view.dart';
import '../modules/support/bindings/support_binding.dart';
import '../modules/support/views/support_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAP_COURSE,
      page: () => MapCourseView(),
      binding: MapCourseBinding(),
    ),
    GetPage(
      name: _Paths.RECHERCHE,
      page: () => RechercheView(),
      binding: RechercheBinding(),
    ),
    GetPage(
      name: _Paths.MA_COURSE,
      page: () => MaCourseView(),
      binding: MaCourseBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NOTE,
      page: () => NoteView(),
      binding: NoteBinding(),
    ),
    GetPage(
      name: _Paths.CHATBOX,
      page: () => ChatboxView(),
      binding: ChatboxBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT,
      page: () => SupportView(),
      binding: SupportBinding(),
    ),
  ];
}
