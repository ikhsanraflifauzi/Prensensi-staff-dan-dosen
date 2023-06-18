import 'package:get/get.dart';

import '../modules/AddEmployee/bindings/add_employee_binding.dart';
import '../modules/AddEmployee/views/add_employee_view.dart';
import '../modules/Daftar/bindings/daftar_binding.dart';
import '../modules/Daftar/views/daftar_view.dart';
import '../modules/DashboardEmployee/bindings/dashboard_employee_binding.dart';
import '../modules/DashboardEmployee/views/dashboard_employee_view.dart';
import '../modules/Explain1/bindings/explain1_binding.dart';
import '../modules/Explain1/views/explain1_view.dart';
import '../modules/FingerAuth/bindings/finger_auth_binding.dart';
import '../modules/FingerAuth/views/finger_auth_view.dart';
import '../modules/ForgotPassword/bindings/forgot_password_binding.dart';
import '../modules/ForgotPassword/views/forgot_password_view.dart';
import '../modules/ImpresionPage/bindings/impresion_page_binding.dart';
import '../modules/ImpresionPage/views/impresion_page_view.dart';
import '../modules/IzinSakit/bindings/izin_sakit_binding.dart';
import '../modules/IzinSakit/views/izin_sakit_view.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/Password_Updates/bindings/password_updates_binding.dart';
import '../modules/Password_Updates/views/password_updates_view.dart';
import '../modules/Presensi/bindings/presensi_binding.dart';
import '../modules/Presensi/views/presensi_view.dart';
import '../modules/Profile/bindings/profile_binding.dart';
import '../modules/Profile/views/profile_view.dart';
import '../modules/Riwayat_GetPass/bindings/riwayat_get_pass_binding.dart';
import '../modules/Riwayat_GetPass/views/riwayat_get_pass_view.dart';
import '../modules/Riwayat_Izin/bindings/riwayat_izin_binding.dart';
import '../modules/Riwayat_Izin/views/riwayat_izin_view.dart';
import '../modules/Riwayat_Presensi/bindings/riwayat_presensi_binding.dart';
import '../modules/Riwayat_Presensi/views/riwayat_presensi_view.dart';
import '../modules/Surat_keluar/bindings/surat_keluar_binding.dart';
import '../modules/Surat_keluar/views/surat_keluar_view.dart';
import '../modules/TimeControl/bindings/time_control_binding.dart';
import '../modules/TimeControl/views/time_control_view.dart';
import '../modules/Update_Profile/bindings/update_profile_binding.dart';
import '../modules/Update_Profile/views/update_profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/user_control/bindings/user_control_binding.dart';
import '../modules/user_control/views/user_control_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
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
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_EMPLOYEE,
      page: () => const DashboardEmployeeView(),
      binding: DashboardEmployeeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => const UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD_UPDATES,
      page: () => const PasswordUpdatesView(),
      binding: PasswordUpdatesBinding(),
    ),
    GetPage(
      name: _Paths.USER_CONTROL,
      page: () => const UserControlView(),
      binding: UserControlBinding(),
    ),
    GetPage(
      name: _Paths.SURAT_KELUAR,
      page: () => const SuratKeluarView(),
      binding: SuratKeluarBinding(),
    ),
    GetPage(
      name: _Paths.IZIN_SAKIT,
      page: () => const IzinSakitView(),
      binding: IzinSakitBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_GET_PASS,
      page: () => const RiwayatGetPassView(),
      binding: RiwayatGetPassBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_IZIN,
      page: () => const RiwayatIzinView(),
      binding: RiwayatIzinBinding(),
    ),
    GetPage(
      name: _Paths.TIME_CONTROL,
      page: () => const TimeControlView(),
      binding: TimeControlBinding(),
    ),
  ];
}
