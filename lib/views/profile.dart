import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.width * 0.35,
              width: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('http://vignette1.wikia.nocookie.net/doblaje/images/d/d6/C-3PO_rebels.png/revision/latest?cb=20170108021237&path-prefix=es'),
                ),
              ),
            ),
          ),
          ListTile(title: Text('C-3PO', textAlign: TextAlign.center, style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
