import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../repositories/auth/auth_repository.dart';

class UserProfileIcon extends StatelessWidget {
  const UserProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthRepository>(builder: (context, authRepository, child) {
      return PopupMenuButton<String>(
          style: ButtonStyle(iconSize: WidgetStateProperty.all(30)),
          offset: const Offset(0, 50),
          // メニューの表示位置調整
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          icon: authRepository.isAuthenticated
              ? Icon(Icons.person)
              : Icon(Icons.person_off_sharp),
          itemBuilder: (context) => _buildPopupMenuItems(authRepository));
    });
  }

  List<PopupMenuEntry<String>> _buildPopupMenuItems(
      AuthRepository authRepository) {
    if (authRepository.isAuthenticated) {
      return [
        // ヘッダーエリア
        _buildUserInfoHeader(authRepository),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'userConfig',
          child: Row(
            children: const [
              Icon(Icons.settings),
              SizedBox(width: 10),
              Text('設定'),
            ],
          ),
        )
      ];
    } else {
      return [
        // ヘッダーエリア
        _buildUserInfoHeader(authRepository),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'login',
          child: Row(
            children: const [
              Icon(Icons.login),
              SizedBox(width: 10),
              Text('ログイン'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'signup',
          child: Row(
            children: const [
              Icon(Icons.app_registration),
              SizedBox(width: 10),
              Text('新規登録'),
            ],
          ),
        )
      ];
    }
  }

  PopupMenuItem<String> _buildUserInfoHeader(AuthRepository authRepository) {
    return PopupMenuItem(
      enabled: false,
      height: 100,
      child: SizedBox(
        width: 250,
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text(authRepository.loggedInUser?.name ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(authRepository.loggedInUser?.email ?? "",
                style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }
}
