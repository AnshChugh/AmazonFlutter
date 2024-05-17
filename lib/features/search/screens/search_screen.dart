import 'package:amazon_flutter/features/auth/widgets/loader.dart';
import 'package:amazon_flutter/features/search/services/search_services.dart';
import 'package:amazon_flutter/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.searchQuery});
  static const String routeName = '/search-screen';

  final String searchQuery;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchServices = SearchServices();
  List<Product>? products;
  @override
  void initState() {
    super.initState();
    fetchSearchedProducts();
  }

  void fetchSearchedProducts() async {
    products = await searchServices.fetchSearchedProducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: Center(child: Text(widget.searchQuery)),
          );
  }
}
