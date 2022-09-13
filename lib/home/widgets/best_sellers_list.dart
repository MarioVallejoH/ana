// import 'package:customer_app/products/product_details/screens/product_details.dart';
// import 'package:customer_app/products/product_details/services/products_data_service.dart';
// import 'package:customer_app/products/products.dart';
// import 'package:customer_app/products/products_related/widgets/product_card_h.dart';

// import 'package:flutter/material.dart';
// import 'outstanding_skeleton.dart';

// import 'package:nb_utils/nb_utils.dart';

// class BestSellerList extends StatefulWidget {
//   const BestSellerList({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<BestSellerList> createState() => _BestSellerListState();
// }

// class _BestSellerListState extends State<BestSellerList> {
//   final _productsDataService = ProductsDataService();
//   final _scrollController = ScrollController();

//   bool _loading = false;

//   int _page = 0;

//   // bool _allLoaded = false;

//   @override
//   void initState() {
//     _scrollController.addListener(infinityScrollListener);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   final _productDataService = ProductsDataService();

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.only(left: 15),
//       scrollDirection: Axis.horizontal,
//       controller: _scrollController,
//       child: StreamBuilder(
//         stream: _productsDataService.bestSellersStream,
//         builder: (BuildContext context,
//             AsyncSnapshot<List<ProductModel>?> snapshot) {
//           if (snapshot.hasData) {
//             if (_productDataService.reloadedBestSellers) {
//               _scrollController.animateToPosition(0, milliseconds: 500);
//               _productDataService.reloadedBestSellers = false;
//             }
//             return Row(
//                 children: List.generate(
//               snapshot.data!.length,
//               (index) => Container(
//                 margin: const EdgeInsets.only(right: 15),
//                 child: ProductCardH(
//                   product: snapshot.data![index],
//                   onTap: () async {
//                     if (!_loading) {
//                       _loading = true;
//                       // UiControllService.closeExploreSearchField();

//                       await ProductDetails(
//                         product: snapshot.data![index],
//                       ).launch(context,
//                           duration: const Duration(milliseconds: 350),
//                           pageRouteAnimation: PageRouteAnimation.Slide);
//                       _loading = false;
//                     }
//                   },
//                 ),
//               ),
//             ));
//           } else {
//             return FutureBuilder(
//               future: _productDataService.loadBestSellers,
//               builder: (BuildContext context, AsyncSnapshot snapshot2) {
//                 if (snapshot2.hasData) {
//                   _productsDataService.setBestSellers(snapshot2.data);
//                 }
//                 // return const BestSellersSkeleton();
//                 return const OutstandingSkeleton();
//               },
//             );
//           }
//         },
//       ),
//     );
//   }

//   void infinityScrollListener() async {
//     // printConsole(_scrollController.position.extentAfter);
//     if (_scrollController.position.pixels >=
//             _scrollController.position.maxScrollExtent &&
//         !_loading) {
//       setState(() {
//         _page += 1;
//         _loading = true;
//       });

//       _loading = true;
//       await _productDataService.addBestSellersPage(_page);
//       setState(() {
//         // widget.products.clear();

//         _loading = false;
//       });
//     }
//   }
// }
