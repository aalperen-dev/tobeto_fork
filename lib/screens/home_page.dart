import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Toplam sekme sayısı
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            "lib/assets/images/tobeto-logo.png",
            width: 200,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 235, 235, 235),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "TOBETO",
                        style: TextStyle(
                          fontSize: 29,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 153, 51, 255),
                          fontFamily: "Poppins",
                        ),
                      ),
                      Text(
                        "'ya Hoş Geldin",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 77, 77, 77),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Text(
                    "İsim!",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 77, 77, 77),
                    ),
                  ),
                ),
                const Text(
                  "Yeni nesil öğrenme deneyimi ile Tobeto kariyer yolculuğunda senin yanında!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20), // Boşluk ekledik
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 30, 0, 30),
                                child: Image.asset(
                                  "lib/assets/images/ik-logo.png",
                                  width: 200,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                                child: Text(
                                  "Ücretsiz eğitimlerle, \n geleceğin mesleklerinde \n sen  de yerini al.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(text: 'Aradığın '),
                                    TextSpan(
                                      text: '"',
                                      style: TextStyle(
                                        fontSize: 26,
                                        color: Color.fromARGB(255, 0, 210, 155),
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'İş',
                                    ),
                                    TextSpan(
                                      text: '" ',
                                      style: TextStyle(
                                        fontSize: 26,
                                        color: Color.fromARGB(255, 0, 210, 155),
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    TextSpan(text: 'Burada!'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 3,
                        tabs: [
                          Tab(text: 'Duyurular'),
                          Tab(text: 'Anketler'),
                          Tab(text: 'Sınavlar'),
                        ],
                      ),
                      const SizedBox(
                        height: 250, // TabBarView'ın yüksekliği
                        child: TabBarView(
                          children: [
                            // Duyurular içeriği
                            Center(child: Text('Duyurular İçeriği')),
                            // Anketler içeriği
                            Center(child: Text('Anketler İçeriği')),
                            // Sınavlar içeriği
                            Center(child: Text('Sınavlar İçeriği')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        stops: [0.01, 1.0],
                        colors: [
                          Color.fromARGB(255, 185, 167, 240),
                          Color.fromARGB(255, 29, 11, 140),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Text(
                            "Profilini oluştur",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 153, 51, 255),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Başla",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        stops: [0.01, 1.0],
                        colors: [
                          Color.fromARGB(255, 88, 198, 179),
                          Color.fromARGB(255, 29, 11, 140),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Text(
                            "Kendini değerlendir",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 153, 51, 255),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Başla",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        stops: [0.01, 1.0],
                        colors: [
                          Color.fromARGB(255, 174, 151, 243),
                          Color.fromARGB(255, 29, 11, 140),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Text(
                            "Öğrenmeye başla",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 153, 51, 255),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Başla",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
