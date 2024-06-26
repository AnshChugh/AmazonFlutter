import 'package:amazon_flutter/constants/global_variables.dart';
import 'package:amazon_flutter/features/auth/widgets/loader.dart';
import 'package:amazon_flutter/features/search/services/search_services.dart';
import 'package:amazon_flutter/features/search/widgets/searched_product.dart';
import 'package:amazon_flutter/home/widgets/address_box.dart';
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

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: GlobalVariables.appBarGradient),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 42,
                        margin: const EdgeInsets.only(left: 15),
                        child: Material(
                          borderRadius: BorderRadius.circular(7),
                          elevation: 1,
                          child: TextFormField(
                            onFieldSubmitted: navigateToSearchScreen,
                            decoration: InputDecoration(
                              prefixIcon: InkWell(
                                onTap: () {},
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                    left: 6,
                                  ),
                                  child: Icon(
                                    Icons.search,
                                    size: 23,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.only(top: 18),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide.none),
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1)),
                              hintText: 'Search Amazon.in',
                              hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        color: Colors.transparent,
                        height: 42,
                        margin: const EdgeInsets.symmetric(horizontal: 18),
                        child: const Icon(
                          Icons.mic,
                          color: Colors.black,
                          size: 25,
                        )),
                  ],
                ))),
        body: products == null
            ? const Loader()
            : Column(
                children: [
                  const AddressBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: products!.length,
                      itemBuilder: (context, index) {
                        return SearchedProduct(product: products![index]);
                      },
                    ),
                  )
                ],
              ));
  }
}
