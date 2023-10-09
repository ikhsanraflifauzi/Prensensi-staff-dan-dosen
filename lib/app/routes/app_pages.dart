import 'package:get/get.dart';

import '../modules/Daftar/bindings/daftar_binding.dart';
import '../modules/Daftar/views/daftar_view.dart';
import '../modules/ForgotPassword/bindings/forgot_password_binding.dart';
import '../modules/ForgotPassword/views/forgot_password_view.dart';
import '../modules/GetPassLanding/bindings/getPass_landing_binding.dart';
import '../modules/GetPassLanding/views/getpass_landing_view.dart';
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
import '../modules/Update_Profile/bindings/update_profile_binding.dart';
import '../modules/Update_Profile/views/update_profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/rekap_Data/bindings/rekap_data_binding.dart';
import '../modules/rekap_Data/views/rekap_data_view.dart';
import '../modules/screenlock/bindings/screenlock_binding.dart';
import '../modules/screenlock/views/screenlock_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.FINGER_AUTH;

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
    GetPage(
      name: _Paths.ADD_EMPLOYEE,
      page: () => const GetPassLandingView(),
      binding: GetPassLandingBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
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
      name: _Paths.SCREENLOCK,
      page: () => const ScreenlockView(),
      binding: ScreenlockBinding(),
    ),
    GetPage(
      name: _Paths.REKAP_DATA,
      page: () => const RekapDataView(),
      binding: RekapDataBinding(),
    ),
  ];
}
