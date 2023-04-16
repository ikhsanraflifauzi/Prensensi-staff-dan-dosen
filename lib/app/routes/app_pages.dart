import 'package:get/get.dart';

import '../modules/AddEmployee/bindings/add_employee_binding.dart';
import '../modules/AddEmployee/views/add_employee_view.dart';
import '../modules/Daftar/bindings/daftar_binding.dart';
import '../modules/Daftar/views/daftar_view.dart';
import '../modules/Explain1/bindings/explain1_binding.dart';
import '../modules/Explain1/views/explain1_view.dart';
import '../modules/FingerAuth/bindings/finger_auth_binding.dart';
import '../modules/FingerAuth/views/finger_auth_view.dart';
import '../modules/ImpresionPage/bindings/impresion_page_binding.dart';
import '../modules/ImpresionPage/views/impresion_page_view.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/Presensi/bindings/presensi_binding.dart';
import '../modules/Presensi/views/presensi_view.dart';
import '../modules/Riwayat_Presensi/bindings/riwayat_presensi_binding.dart';
import '../modules/Riwayat_Presensi/views/riwayat_presensi_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/newPassword/bindings/new_password_binding.dart';
import '../modules/newPassword/views/new_password_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_PRESENSI,
      page: () => const RiwayatPresensiView(),
      binding: RiwayatPresensiBinding(),
    ),
    GetPage(
      name: _Paths.DAFTAR,
      page: () => const DaftarView(),
      binding: DaftarBinding(),
    ),
    GetPage(
      name: _Paths.PRESENSI,
      page: () => const PresensiView(),
      binding: PresensiBinding(),
    ),
    // GetPage(
    //   name: _Paths.IMPRESION_PAGE,
    //   page: () => const ImpresionPageView(),
    //   binding: ImpresionPageBinding(),
    // ),
    // GetPage(
    //   name: _Paths.EXPLAIN1,
    //   page: () => const Explain1View(),
    //   binding: Explain1Binding(),
    // ),
    GetPage(
      name: _Paths.ADD_EMPLOYEE,
      page: () => const AddEmployeeView(),
      binding: AddEmployeeBinding(),
    ),
    GetPage(
      name: _Paths.FINGER_AUTH,
      page: () => const FingerAuthView(),
      binding: FingerAuthBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => const NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
  ];
}
