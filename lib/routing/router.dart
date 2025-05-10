import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/routing/routes.dart';
import 'package:training_todo/ui/add_todo/view_models/add_todo_view_model.dart';
import 'package:training_todo/ui/top/top_screen.dart';

import '../ui/add_todo/add_todo_screen.dart';
import '../ui/top/view_models/top_viewmodel.dart';

GoRouter router() => GoRouter(initialLocation: Routes.home, routes: [
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (context) => TopViewmodel(context.read()),
            child: TopScreen(),
          );
        },
      ),
      GoRoute(
        path: Routes.addTodo,
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (context) => AddTodoViewModel(),
            child: AddTodoScreen(),
          );
        },
      ),
    ]);
