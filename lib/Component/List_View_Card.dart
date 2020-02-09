import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: FlutterLogo(size: 60.0),
            title: Text('Addidas Phantom'),
            subtitle: Text('\$63'),
            trailing: Column(
              children: <Widget>[
                Expanded(
                    child: IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {},
                )),
                SizedBox(
                  height: 20,
                ),
                Expanded(child: Text("1")),
                Expanded(
                    child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {},
                ))
              ],
            ),
            // isThreeLine: true,
          ),
        ],
      ),
    );
  }
}
