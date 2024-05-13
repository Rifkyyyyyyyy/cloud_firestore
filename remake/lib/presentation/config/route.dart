import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remake/common/components/bottom/bottom.dart';
import 'package:remake/constant/endpoint.dart';
import 'package:remake/presentation/page/test1page.dart';
import 'package:remake/presentation/page/test2page.dart';
import 'package:remake/presentation/page/test3page.dart';
import 'package:remake/presentation/view/view.dart';


final GlobalKey<NavigatorState> globalKey = GlobalKey();

GoRouter goRouter() {
  return GoRouter(
    navigatorKey: globalKey,
    initialLocation: pathEndpoint(endpoints: Endpoint.home),
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            BottomNav(shellBranch: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: pathEndpoint(endpoints: Endpoint.home),
              pageBuilder: (context, state) => CustomTransitionPage(
                child: const MyHomepage(),
                transitionsBuilder: (ctx, animation, secondary, child) {
                  const begin = 0.0;
                  const end = 1.0;
                  var tween = Tween(begin: begin, end: end);
                  var opacityAnimation = tween.animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.fastOutSlowIn,
                  ));
                  return FadeTransition(
                    opacity: opacityAnimation,
                    child: child,
                  );
                },
              ),
            ),
          ]),
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: pathEndpoint(endpoints: Endpoint.analytics),
              pageBuilder: (context, state) => CustomTransitionPage(
                child: const Page1(),
                transitionsBuilder: (ctx, animation, secondary, child) {
                  const begin = 0.0;
                  const end = 1.0;
                  var tween = Tween(begin: begin, end: end);
                  var opacityAnimation = tween.animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.fastOutSlowIn,
                  ));
                  return FadeTransition(
                    opacity: opacityAnimation,
                    child: child,
                  );
                },
              ),
            ),
          ]),
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: pathEndpoint(endpoints: Endpoint.calendar),
              pageBuilder: (context, state) => CustomTransitionPage(
                child: const Page2(),
                transitionsBuilder: (ctx, animation, secondary, child) {
                  const begin = 0.0;
                  const end = 1.0;
                  var tween = Tween(begin: begin, end: end);
                  var opacityAnimation = tween.animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.fastOutSlowIn,
                  ));
                  return FadeTransition(
                    opacity: opacityAnimation,
                    child: child,
                  );
                },
              ),
            ),
          ]),
            StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: pathEndpoint(endpoints: Endpoint.profile),
              pageBuilder: (context, state) => CustomTransitionPage(
                child: const Page3(),
                transitionsBuilder: (ctx, animation, secondary, child) {
                  const begin = 0.0;
                  const end = 1.0;
                  var tween = Tween(begin: begin, end: end);
                  var opacityAnimation = tween.animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.fastOutSlowIn,
                  ));
                  return FadeTransition(
                    opacity: opacityAnimation,
                    child: child,
                  );
                },
              ),
            ),
          ]),
        ],
      ),
     
    ],
  );
}
