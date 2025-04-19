import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:training_todo/routing/routes.dart';
import 'package:training_todo/ui/top/top_screen.dart';

import '../ui/top/view_models/top_viewmodel.dart';

GoRouter router() => GoRouter(initialLocation: Routes.home, routes: [
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (context) =>
                TopViewmodelDatabase(context.read(), context.read()),
            child: TopScreen(),
          );
        },
      ),
    ]);
