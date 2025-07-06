@GenerateNiceMocks([
  MockSpec<AuthRepository>(),
  MockSpec<TodoRepository>(),
  MockSpec<AuthServiceLocal>(),
  MockSpec<AuthSessionStoreLocal>(),
])
import 'package:mockito/annotations.dart';
import 'package:training_todo/repositories/auth/auth_repository.dart';
import 'package:training_todo/repositories/todo/todo_repository.dart';
import 'package:training_todo/services/auth/auth_service_local.dart';
import 'package:training_todo/services/auth/auth_session_store_local.dart';
