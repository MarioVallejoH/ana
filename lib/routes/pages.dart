
import 'package:customer_app/auth/controller/auth_binding.dart';
import 'package:customer_app/cart/cart/controllers/cart_binding.dart';
import 'package:customer_app/cart/cart/controllers/cart_middleware.dart';
import 'package:customer_app/cart/edit_cart_item/controller/edit_cart_item_binding.dart';
import 'package:customer_app/cart/edit_cart_item/controller/edit_cart_item_middleware.dart';
import 'package:customer_app/cart/edit_cart_item/screens/edit_cart_product.dart';
import 'package:customer_app/explore/controllers/explore_binding.dart';
import 'package:customer_app/favorites/controllers/favorites_binding.dart';
import 'package:customer_app/favorites/controllers/favorites_middleware.dart';
import 'package:customer_app/home/controllers/home_binding.dart';
import 'package:customer_app/home/images/controller/image_binding.dart';
import 'package:customer_app/orders/orders_list/controllers/order_list_binding.dart';
import 'package:customer_app/orders/orders_list/controllers/order_list_middleware.dart';
import 'package:customer_app/orders/orders_list/screens/orders.dart';
import 'package:customer_app/products/outstanding/controller/outstandings_binding.dart';
import 'package:customer_app/products/products_related/controller/products_related_binding.dart';
import 'package:customer_app/products/products_related/controller/products_related_middleware.dart';
import 'package:customer_app/register/controller/register_binding.dart';
import 'package:customer_app/register/screens/register.dart';
import 'package:customer_app/root/controllers/root_binding.dart';
import 'package:customer_app/root/screens/root_app.dart';
import 'package:customer_app/auth/screens/login.dart';
import 'package:customer_app/routes/routes.dart';
import 'package:customer_app/routes/screen/init_load_screen.dart';
import 'package:customer_app/user/controllers/user_binding.dart';
import 'package:customer_app/user/screens/user_screen.dart';
import 'package:customer_app/utils/global_bindings.dart';
import 'package:get/get.dart';

/// Clase donde se definen las pantallas de la app
class Pages {
  /// Lista de pantallas
  static List<GetPage> pages() => [
        GetPage(
          name: Routes.initLoading,
          page: () => const InitLoading(),
          binding: GlobalBinding(),
        ),
        GetPage(
          name: Routes.login,
          page: () => const Login(),
          binding: AuthBinding(),
        ),
        GetPage(name: Routes.home, page: () => RootApp(), bindings: [
          RootBinding(),
          ProductsRelatedBinding(),
          HomeBinding(),
          ExploreBinding(),
          FavoritesBinding(),
          CartBinding(),
          OutstandingBinding(),
        ], middlewares: [
          // RootMiddleware(),
          ProductsRelatedMiddleware(),
          FavoritesMiddleware(),
          CartMiddleware(),
        ]

            // middlewares: [
            //   VehicleMiddleware(),
            // ],
            ),
        
        GetPage(
          name: Routes.user,
          page: () => const UserScreen(),
          bindings: [ImageBinding(), UserBinding()],
        ),
        GetPage(
          name: Routes.register,
          page: () => const UserRegister(),
          bindings: [
            ImageBinding(),
            RegisterBinding(),
          ],
        ),
        GetPage(
          name: Routes.editCartItem,
          page: () => EditCartItemScreen(),
          binding: EditCartItemBinding(),
          middlewares: [EditCartItemMiddleware()],
        ),
        GetPage(
          name: Routes.ordersList,
          page: () => const Orders(),
          binding: OrdersListBinding(),
          middlewares: [
            OrdersListMiddleware(),
          ],
        ),
      ];
}
