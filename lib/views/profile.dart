import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tec_pass/bloc/customnavbar/customnavbar_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<CustomNavBarBloc>(context).add(ShowcaseStart());
            },
            child: Container(
              margin: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.width * 0.35,
              width: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('https://www.zbrushcentral.com/uploads/default/original/4X/c/7/a/c7a39f1c8da575307d9cfd23c55811e03d9b7f76.jpeg'),
                ),
              ),
            ),
          ),
          ListTile(title: Text('Pain Harold', textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}
