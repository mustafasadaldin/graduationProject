import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 15, right: 10),
                  child: InkWell(
                    child: Image.asset(
                      'imagess/icons-back.png',
                      height: 30,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Text(
                    'About',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Image.asset("imagess/logog.png"),
            ),
            SizedBox(
              height: 50,
            ),
            FadeInDown(
              delay: Duration(microseconds: 500),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "The largest fitness club in Nablus, designed with the latest modern designs.The club consists of two separate halls for men and women, equipped with all the advanced and modern sports equipment necessary to build a perfect body, with the help of the most skilled trainers who have local and international certificates and championships. And it was equipped with accurate and modern safety devices to feel comfortable when exercising.The club provides all necessary services to subscribers, as it has a cafeteria and a special section for selling proteins.",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: Text('Rafidya St., Nablus, Palestine'),
                      leading: Icon(
                        Icons.location_pin,
                        color: Color.fromARGB(255, 14, 14, 14),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text('+970 597 633 980'),
                      leading: Icon(
                        Icons.phone,
                        color: Color.fromARGB(255, 16, 16, 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
