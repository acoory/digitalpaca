import 'package:digitalpaca/model/series.dart';
import 'package:digitalpaca/navigation/new_drawer.dart';
import 'package:digitalpaca/provider/favories_provider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class DescriptionView extends StatefulWidget {
  final Series serie;
  const DescriptionView({super.key, required this.serie});

  @override
  State<DescriptionView> createState() => _DescriptionViewState();
}

class _DescriptionViewState extends State<DescriptionView> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const NewDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(19, 61, 82, 1)),
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2 - 50,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.serie.thumbUrl))),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2 - 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.grey.withOpacity(0.0),
                            const Color.fromRGBO(19, 61, 82, 1),
                          ],
                          stops: const [
                            0.0,
                            1.0
                          ])),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2 - 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.serie.title,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {
                                      provider.toggleFavorite(
                                          widget.serie, widget.serie.id);
                                    },
                                    iconSize: 30,
                                    icon: provider.isExistId(widget.serie.id)
                                        ? const Icon(Icons.star,
                                            color:
                                                Color.fromRGBO(241, 202, 75, 1))
                                        : const Icon(Icons.star_outline,
                                            color: Color.fromARGB(
                                                255, 246, 246, 246)))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              // note date description
                              children: [
                                // Note du public
                                Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                      right: BorderSide(
                                        //                   <--- right side
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    )),
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            30,
                                    child: Column(
                                      children: [
                                        CircularPercentIndicator(
                                          radius: 40.0,
                                          lineWidth: 8.0,
                                          percent: widget.serie.rate / 100,
                                          center: Text(
                                            "${widget.serie.rate}%",
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    189, 183, 183, 1),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          progressColor: Colors.green,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text(
                                          "Note du public",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  189, 183, 183, 1),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                                // information de la serie
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 120,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 30),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.serie.duration
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        189, 189, 189, 0.6),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                "Date",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        189, 189, 189, 0.6),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                widget.serie.type,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        189, 189, 189, 0.6),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                "Tous publics",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        189, 189, 189, 0.6),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                "Synopsis :",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                widget.serie.description,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 217, 217, 217),
                                    fontSize: 16.5,
                                    height: 1.3),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
