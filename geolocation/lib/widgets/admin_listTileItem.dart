import 'package:flutter/material.dart';
import '../screens/userDetailsScreen.dart';

class UserListItem extends StatelessWidget {
  final String userId;
  final String userName;
  final double latitude;
  final double longitude;
  final String designation;
  UserListItem(
      {this.designation,
      this.userId,
      this.userName,
      this.latitude,
      this.longitude});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            UserDetailsScreen.routeName,
            arguments: userId,
          );
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          child: ListTile(
            leading: CircleAvatar(
              maxRadius: 25,
              child: FittedBox(
                child: Text(
                  userName.substring(0, 1),
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            title: Text(
              userName,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  designation,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(latitude.toString()),
                    SizedBox(
                      width: 10,
                    ),
                    Text(longitude.toString()),
                  ],
                ),
              ],
            ),
            trailing:
                IconButton(icon: Icon(Icons.chevron_right), onPressed: null),
          ),
        ),
      ),
    );
  }
}
