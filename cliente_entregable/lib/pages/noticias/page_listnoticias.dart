import 'package:cliente_entregable/pages/login_page.dart';
import 'package:cliente_entregable/widgets/menu_widget.dart';
import 'package:cliente_entregable/widgets/panel_user_email.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageListNoticias extends StatefulWidget {
  PageListNoticias({Key? key}) : super(key: key);

  @override
  State<PageListNoticias> createState() => _PageListNoticiasState();
}

class _PageListNoticiasState extends State<PageListNoticias> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserEmail(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Text('...');
        }
        var user = snapshot.data;
        print(user);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: user != "" ? MenuWidget() : null,
            title: Text('Noticias'),
            centerTitle: true,
            backgroundColor: Colors.black87,
            actions: [
              if (user == "")
                IconButton(
                  onPressed: () {
                    MaterialPageRoute route =
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    });
                    Navigator.push(context, route)
                        .then((value) => setState(() {}));
                  },
                  icon: Icon(Ionicons.log_in),
                ),
            ],
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://as2.ftcdn.net/v2/jpg/03/04/35/15/1000_F_304351519_t2XoCRj1J4yYQ3DlhyJTjzBsJQQpZ6mI.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              children: [
                PanelUserEmail(),
                SizedBox(
                  width: 360,
                  height: 400,
                  child: Card(
                    elevation: 6,
                    child: GridTile(
                      header: GridTileBar(
                        backgroundColor: Colors.white,
                        leading: const CircleAvatar(
                          backgroundColor: Colors.deepOrange,
                          child: Text(
                            'K',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                        title: const Text(
                          'KindaCode.com',
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: const Text('5 minutes ago',
                            style: TextStyle(color: Colors.grey)),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_vert_rounded,
                              color: Colors.black54,
                            )),
                      ),
                      child: Image.network(
                        'https://www.kindacode.com/wp-content/uploads/2021/12/sample-leaf.jpeg',
                        fit: BoxFit.cover,
                      ),
                      footer: GridTileBar(
                        backgroundColor: Colors.white,
                        title: Row(
                          children: const [
                            Icon(
                              Icons.favorite_outline,
                              color: Colors.grey,
                            ),
                            Text('20', style: TextStyle(color: Colors.black)),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.grey,
                            ),
                            Text(
                              '5',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        trailing: const Icon(
                          Icons.bookmark_outline,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> getUserEmail() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('userEmail') ?? '';
  }
}
