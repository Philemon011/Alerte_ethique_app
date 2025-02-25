
import 'package:alerte_ethique/home/provider/home_screen_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../core/data/data_provider.dart';


extension Providers on BuildContext {
  DataProvider get dataProvider => Provider.of<DataProvider>(this, listen: false);
  HomeScreenProvider get homeScreenProvider => Provider.of<HomeScreenProvider>(this, listen: false);
}