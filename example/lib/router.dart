import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/screens/admin/translation.screen.dart';
import 'package:example/screens/forum/category/category_edit.screen.dart';
import 'package:example/screens/forum/category/category_list.screen.dart';
import 'package:example/screens/forum/post_view.screen.dart';
import 'package:example/screens/setting/setting.screen.dart';
import 'package:example/screens/user/login.screen.dart';
import 'package:example/screens/user/register.screen.dart';
import 'package:example/screens/widget/custom_popup.screen.dart';
import 'package:example/screens/forum/post_edit.screen.dart';
import 'package:example/screens/forum/post_list.screen.dart';
import 'package:example/screens/home/home.screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: 'Home',
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: 'CategoryList',
      path: '/categoryList',
      builder: (context, state) => const CategoryListScreen(),
    ),
    GoRoute(
      name: 'CategoryEdit',
      path: '/categoryEdit',
      builder: (context, state) =>
          CategoryEditScreen(category: state.queryParams['category']),
    ),
    GoRoute(
      name: 'CustomPopup',
      path: '/customPopup',
      builder: (context, state) => const CustomPopupScreen(),
    ),
    GoRoute(
      name: 'PostList',
      path: '/postList',
      builder: (context, state) {
        return PostListScreen(category: state.queryParams['category']!);
      },
    ),
    GoRoute(
      name: 'PostEdit',
      path: '/postEdit',
      builder: (context, state) {
        return PostEditScreen(
          category: state.queryParams['category'],
          postId: state.queryParams['postId'],
        );
      },
    ),
    GoRoute(
      name: 'PostView',
      path: '/postView',
      builder: (context, state) {
        return PostViewScreen(
          postDocumentReference: FirebaseFirestore.instance
              .doc(state.queryParams['postDocumentReference']!),
        );
      },
    ),
    GoRoute(
      name: 'Register',
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      name: 'Login',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: 'Setting',
      path: '/setting',
      builder: (context, state) => const SettingScreen(),
    ),
    GoRoute(
      name: 'AdminTranslation',
      path: '/adminTranslation',
      builder: (context, state) => const AdminTranslationScreen(),
    ),
  ],
);
