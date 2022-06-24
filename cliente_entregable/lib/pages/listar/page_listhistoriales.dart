import 'package:cliente_entregable/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class PageListHistoriales extends StatefulWidget {
  PageListHistoriales({Key? key}) : super(key: key);

  @override
  State<PageListHistoriales> createState() => _PageListHistorialesState();
}

class _PageListHistorialesState extends State<PageListHistoriales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: MenuWidget(),
        title: Text('Historiales'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://as2.ftcdn.net/v2/jpg/03/04/35/15/1000_F_304351519_t2XoCRj1J4yYQ3DlhyJTjzBsJQQpZ6mI.jpg"),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
