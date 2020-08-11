import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions {
  Favrorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    // final productContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Da Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favrorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favrorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, badgeChild) => Badge(
              child: badgeChild,
              value: cart.itemCount.toString(),
            ),
            //When you are only changing 1 element of a widget based on dynamic data...
            // But the rest of the widget SHOULDNT need to rebuild. Add the static stuff
            // as a child to the Consumer's builder
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}

// class ProductsOverviewScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final productContainer = Provider.of<Products>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Da Shop'),
//         actions: <Widget>[
//           PopupMenuButton(
//               onSelected: (FilterOptions selectedValue) {
//                 if (selectedValue == FilterOptions.Favrorites) {
//                   productContainer.showFavoritesOnly();
//                 } else {
//                   productContainer.showAll();
//                 }
//               },
//               icon: Icon(Icons.more_vert),
//               itemBuilder: (_) => [
//                     PopupMenuItem(
//                       child: Text('Only Favorites'),
//                       value: FilterOptions.Favrorites,
//                     ),
//                     PopupMenuItem(
//                       child: Text('Show All'),
//                       value: FilterOptions.All,
//                     ),
//                   ])
//         ],
//       ),
//       body: ProductsGrid(),
//     );
//   }
// }
