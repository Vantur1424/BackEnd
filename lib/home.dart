import 'package:flutter/material.dart';
import 'detailpage.dart';
import 'provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ScreenPageProvider>(context);
    return Scaffold(
        body: Center(
      child: FutureBuilder(
        future: prov.initializeCoffe(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('Tidak ada data');
          } else {
            if (prov.coffe.isNotEmpty) {
              var firstCoffe = prov.coffe[0];
              print(firstCoffe.nama);
              return Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(firstCoffe.nama),
                    Expanded(
                        child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: prov.isSearching
                          ? prov.coffe.length
                          : prov.coffe.length,
                      itemBuilder: (context, index) {
                        final coffe = prov.isSearching
                            ? prov.searchResult[index]
                            : prov.coffe[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ScreenDetail(data: coffe.nama)));
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                        image: AssetImage(coffe.img),
                                        fit: BoxFit.cover)),
                              ),
                              Positioned(
                                bottom: 12,
                                left: 10,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    coffe.nama,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ))
                  ],
                ),
              );
            } else {
              return const Text('Daftar kopi kosong');
            }
          }
        },
      ),
    ));
  }
}
