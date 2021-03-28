// import 'package:flutter/material.dart';
// import 'package:menon10/navigation_bar/navbar_item.dart';

// class DrawerItem extends StatefulWidget {
//   final String title;
//   final IconData icon;
//   Widget temp;
//   const DrawerItem(this.title, this.icon, this.temp);

//   @override
//   _DrawerItemState createState() => _DrawerItemState();
// }

// class _DrawerItemState extends State<DrawerItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 30, top: 25),
//       child: ListTile(
//         title: NavBarItem(widget.title),
//         leading: Icon(
//           widget.icon,
//           size: 30,
//         ),
//         onTap: () {
//           switch (this.widget.title) {
//             case "Reports":
//               widget.temp = Reports();
//               break;
//             default:
//           }
//         },
//       ),
//     );
//   }
// }
