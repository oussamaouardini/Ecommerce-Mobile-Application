import 'package:flutter/material.dart';
import 'package:pfe/Screens/edit_account.dart';
import 'package:pfe/user/user.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

const appBarColor = Color(0xFF01B2C4);
const AppColor = Color(0xFFDBDBDB);

class Account extends StatefulWidget {
  final firstName;

  final lastName;

  final email;

  final password;

  final memberSince, shippingAddress, mobile;

  Account(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.memberSince,
      this.shippingAddress,
      this.mobile});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: appBarColor,
        title: ListTile(
          title: InkWell(
            child: Text(
              'My Account',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            onTap: () {},
          ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      bottomNavigationBar: TitledBottomNavigationBar(
          currentIndex: 4, // Use this to update the Bar giving a position
          onTap: (index) {},
          items: [
            TitledNavigationBarItem(title: 'Home', icon: Icons.home),
            TitledNavigationBarItem(title: 'Search', icon: Icons.search),
            TitledNavigationBarItem(title: 'Favorite', icon: Icons.favorite),
            TitledNavigationBarItem(title: 'Orders', icon: Icons.shopping_cart),
            TitledNavigationBarItem(
                title: 'Profile', icon: Icons.person_outline),
          ]),
      body: ListView(
        children: <Widget>[
          Card(
            // color: Colors.yellowAccent,
            child: ListTile(
              title: Text(widget.firstName + ' ' + widget.lastName),
              subtitle: Text(widget.email),
              trailing: IconButton(
                icon: Icon(Icons.perm_identity),
                iconSize: 50,
                onPressed: () {},
              ),
            ),
          ),

          ///  My Orders Setting --------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.shopping_cart),
                        Text(
                          "My Orders",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    trailing: Text("View All"),
                  ),
                  ListTile(
                    title: Text("Unpaid"),
                    trailing: Container(
                      width: 40.0,
                      height: 40.0,
                      child: Center(child: Text("2")),
                      decoration: BoxDecoration(
                          color: AppColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                  ListTile(
                    title: Text("To be Shipped"),
                    trailing: Container(
                      width: 40.0,
                      height: 40.0,
                      child: Center(child: Text("2")),
                      decoration: BoxDecoration(
                          color: AppColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                  ListTile(
                    title: Text("Shipped"),
                    trailing: Container(
                      width: 40.0,
                      height: 40.0,
                      child: Center(child: Text("2")),
                      decoration: BoxDecoration(
                          color: AppColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                  ListTile(
                    title: Text("In dispute"),
                    trailing: Container(
                      width: 40.0,
                      height: 40.0,
                      child: Center(child: Text("2")),
                      decoration: BoxDecoration(
                          color: AppColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ],
              ),
            ),
          ),

          ///  Profile Setting --------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.person_outline),
                        Text(
                          "Profile Settings",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    trailing: InkWell(
                      child: Text("Edit"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                      widget.firstName,
                                      widget.lastName,
                                      widget.email,
                                      widget.shippingAddress,
                                      widget.mobile,
                                    )));
                      },
                    ),
                  ),
                  ListTile(
                    title: Text("Full name"),
                    trailing: Text(widget.firstName + ' ' + widget.lastName),
                  ),
                  ListTile(
                    title: Text("Email"),
                    trailing: Text(widget.email),
                  ),
                  ListTile(
                    title: Text("Mobile"),
                    trailing: widget.mobile != null
                        ? Text(widget.mobile)
                        : Text('Add phone Number'),
                  ),
                  ListTile(
                    title: Text("shipping Address"),
                    trailing: widget.shippingAddress != null
                        ? Text(widget.shippingAddress)
                        : Text('Add address'),
                  ),
                  ListTile(
                    title: Text("Member Since"),
                    trailing: Text(widget.memberSince),
                  ),
                ],
              ),
            ),
          ),

          ///  Account Setting --------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.settings),
                        Text(
                          "Account Settings",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    trailing: Text("Edit"),
                  ),
                  ListTile(
                    title: Text("Shipping Adresses"),
                    trailing: Text("tamawanza-agadir"),
                  ),
                  ListTile(
                    title: Text("Languages"),
                    trailing: Text("English"),
                  ),
                  ListTile(
                    title: Text("Currencies"),
                    trailing: Text("Dollars"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
