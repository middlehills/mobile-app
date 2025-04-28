import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:mid_hill_cash_flow/routes/routes_list/auth_routes.dart';

class MidhillRouter {
  static final returnRouter = GoRouter(
    initialLocation: "/${MidhillRoutesList.splashPage}",
    routes: [...authRoutes],
  );
}
