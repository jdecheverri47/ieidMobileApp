import 'package:flutter/material.dart';
import 'package:ieid/components/qr_offline.dart';
import 'package:ieid/components/qr_online.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(children: [
          ListView(
            shrinkWrap: true, // Ajusta al contenido
            children: <Widget>[
              const TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.wifi),
                  ),
                  Tab(
                    icon: Icon(Icons.wifi_off),
                  ),
                ],
                indicatorColor: Color.fromRGBO(255, 225, 0, 1),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
              ),
              SizedBox(
                height: 300,
                child: TabBarView(
                  children: <Widget>[
                    Center(
                      child: QrOnline(),
                    ),
                    const Center(
                      child: QrOffline(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }
}
