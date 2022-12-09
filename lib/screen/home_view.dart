import 'package:digitalpaca/model/series.dart';
import 'package:digitalpaca/navigation/New_drawer.dart';
import 'package:digitalpaca/provider/favories_provider.dart';
import 'package:digitalpaca/screen/description_view.dart';
import 'package:digitalpaca/services/series_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Series>? series;
  List<Series>? initSeries;

  var isLoader = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  getData() async {
    late SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    series = await SeriesService().getSeries(token);
    initSeries = series;

    if (series != null) {
      setState(() {
        isLoader = true;
      });
    }
  }

  searchSeries(String query) {
    final suggestion = series!.where((element) {
      final seriesTitle = element.title.toLowerCase();
      final input = query.toLowerCase();

      return seriesTitle.contains(input);
    }).toList();

    setState(() {
      series = suggestion;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    return Scaffold(
        drawer: const NewDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 77, 77, 77)),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(078),
                      border:
                          Border.all(color: Color.fromRGBO(189, 189, 189, 1))),
                  child: TextField(
                    style: const TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        fontFamily: "Roboto"),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Recherche',
                        prefixIcon: Icon(Icons.search)),
                    onChanged: (value) {
                      searchSeries(value);
                      if (value.isEmpty) {
                        // getData();
                        isLoader = false;
                        setState(() {
                          series = initSeries;
                          isLoader = true;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Expanded(
                    child: Visibility(
                  visible: isLoader,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: ListView.builder(
                      itemCount: series?.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DescriptionView(
                                        serie: series![index])));
                          },
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 221, 221, 221)),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 216, 216, 216)
                                          .withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                    width: 100,
                                    height: 170,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(078),
                                    ),
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              bottomLeft: Radius.circular(8)),
                                        ),
                                        child: series != null
                                            ? Image.network(
                                                series![index].thumbUrl,
                                                fit: BoxFit.cover,
                                              )
                                            : const Text("data"))),
                                Expanded(
                                  child: Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      height: 150,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                series != null
                                                    ? series![index].title
                                                    : "",
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        84, 84, 84, 1),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                series != null
                                                    ? series![index].year
                                                    : "",
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        189, 183, 183, 1),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Text(series != null
                                              ? "${series![index].description.substring(0, 100)}..."
                                              : ""),
                                        ],
                                      )),
                                ),
                                Container(
                                    padding: const EdgeInsets.only(
                                      top: 0,
                                    ),
                                    width: 45,
                                    height: 170,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          iconSize: 30,
                                          onPressed: () {
                                            provider.toggleFavorite(
                                                series![index],
                                                series![index].id);
                                          },
                                          icon: provider
                                                  .isExistId(series![index].id)
                                              ? const Icon(Icons.star,
                                                  color: Color.fromRGBO(
                                                      241, 202, 75, 1))
                                              : const Icon(Icons.star_outline,
                                                  color: Color.fromRGBO(
                                                      189, 189, 189, 1)),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        );
                      }),
                )),
              ],
            )));
  }
}
