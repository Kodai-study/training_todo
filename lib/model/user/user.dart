import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  factory User(
      {
      /// ユーザの識別子
      required int id,

      /// 表示するユーザ名
      required String name,

      /// ユーザのメールアドレス
      required String email}) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
