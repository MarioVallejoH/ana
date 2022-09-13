
// import 'package:customer_app/home/widgets/outstanding_skeleton.dart';
// import 'package:customer_app/products/product_details/screens/product_details.dart';
// import 'package:customer_app/products/product_details/services/products_data_service.dart';
// import 'package:customer_app/products/products.dart';
// import 'package:customer_app/products/products_related/widgets/product_card_h.dart';
// import 'package:customer_app/services/ui_control_service.dart';
// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';

// class OutstandingList extends StatefulWidget {
//   const OutstandingList({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<OutstandingList> createState() => _OutstandingListState();
// }

// class _OutstandingListState extends State<OutstandingList> {
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
//         stream: _productDataService.outstandingStream,
//         builder: (BuildContext context,
//             AsyncSnapshot<List<ProductModel>?> snapshot) {
//           if (snapshot.hasData) {
//             if (_productDataService.reloadedOutstandings) {
//               _scrollController.animateToPosition(0, milliseconds: 500);
//               _productDataService.reloadedOutstandings = false;
//             }
//             return Row(
//                 children: List.generate(
//               snapshot.data!.length,
//               (index) => Container(
//                 margin: const EdgeInsets.only(right: 15),
//                 child: ProductCardH(
//                     product: snapshot.data![index],
//                     onTap: () async {
//                       if (!_loading) {
//                         UiControllService.closeExploreSearchField();

//                         _loading = true;
//                         await ProductDetails(
//                           product: snapshot.data![index],
//                         ).launch(context,
//                             duration: const Duration(milliseconds: 350),
//                             pageRouteAnimation: PageRouteAnimation.Slide);
//                         _loading = false;
//                       }
//                     }),
//               ),
//             ));
//           } else {
//             return FutureBuilder(
//               future: _productDataService.loadOutstandings,
//               builder: (BuildContext context, AsyncSnapshot snapshot2) {
//                 if (snapshot2.hasData) {
//                   _productDataService.setOutstanding(snapshot2.data);
//                   return const OutstandingSkeleton();
//                 } else {
//                   return const OutstandingSkeleton();
//                 }
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
//       await _productDataService.addOutstandingsPage(_page);
//       setState(() {
//         // widget.products.clear();

//         _loading = false;
//       });
//     }
//   }
// }
