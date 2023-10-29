
// addsupervisor(String value, List listitem, String path) {
//   var supervisor;

//   var cosupervisor;

//   return Column(
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           const Text(
//             "Main Supervisor",
//             style: TextStyle(
//                 color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(
//             width: 30,
//           ),
//           Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14),
//                 color: const Color.fromARGB(255, 223, 219, 219)),
//             child: Padding(
//               padding: EdgeInsets.only(left: 14, top: 3, bottom: 3, right: 14),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton(
//                   focusColor: Colors.grey[200],
//                   hint: const Text(
//                     "Choose Main Supervisor",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   value: supervisor,
//                   onChanged: (newValue) {
//                     setState(() {
//                       supervisor = newValue;
//                     });
//                   },
//                   items: listitem.map((valueItem) {
//                     return DropdownMenuItem(
//                       value: valueItem,
//                       child: Text(valueItem),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ),
//           const Text(
//             "Co Supervisor",
//             style: TextStyle(
//                 color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(
//             width: 45,
//           ),
//           Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14),
//                 color: const Color.fromARGB(255, 223, 219, 219)),
//             child: Padding(
//               padding:
//                   const EdgeInsets.only(left: 14, top: 3, bottom: 3, right: 14),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton(
//                   focusColor: Colors.grey[200],
//                   hint: const Text(
//                     "Choose Co-Supervisor",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   value: cosupervisor,
//                   onChanged: (newValue) {
//                     // setState(() {
//                     //   cosupervisor = newValue;
//                     // });
//                   },
//                   items: listitem.map((valueItem) {
//                     return DropdownMenuItem(
//                       value: valueItem,
//                       child: Text(valueItem),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(
//         height: 20,
//       ),
//       ElevatedButton(
//         onPressed: () {
//           // var db = FirebaseFirestore.instance
//           //     .collection(path)
//           //     .doc(value)
//           //     .collection('supervisor');

//           // db.add({
//           //   "main-supervisor": "Mr Waqar Ahmad",
//           //   "co-supervisor": "Mr. Shahbaz Ahmad Sahi",
//           // });
//           // setState(() {
//           //   showDialog(
//           //       context: context,
//           //       builder: (ctx) => AlertDialog(
//           //             title: const Text(
//           //               "Group Registration",
//           //               style: TextStyle(fontSize: 20),
//           //             ),
//           //             actions: <Widget>[
//           //               TextButton(
//           //                 onPressed: () {
//           // var db = FirebaseFirestore.instance
//           //     .collection(path)
//           //     .doc(document.id)
//           //     .collection('supervisors');

//           // db.add({
//           //   "main-supervisor": supervisor,
//           //   "co-supervisor": cosupervisor,
//           // });

//           //                   Navigator.pop(ctx);
//           //                   // Navigator.push(
//           //                   //     context,
//           //                   //     MaterialPageRoute(
//           //                   //       builder: (context) =>
//           //                   //           StudentDashboard(),
//           //                   //     ));
//           //                 },
//           //                 child: const Text("OK"),
//           //               ),
//           //             ],
//           //             content: const Text("Successful",
//           //                 style: TextStyle(
//           //                     color: Color.fromARGB(255, 20, 107, 23))),
//           //           ));
//           // });
//         },
//         style: ElevatedButton.styleFrom(
//             primary: const Color.fromARGB(255, 57, 120, 125),
//             padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
//             textStyle:
//                 const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//         child: const Text('Allocate'),
//       )
//     ],
//   );
// }

 










// class ButtonStream extends StatefulWidget {
//   const ButtonStream({super.key});

//   @override
//   State<ButtonStream> createState() => _ButtonStreamState();
// }

// class _ButtonStreamState extends State<ButtonStream> {
//   var firebaseUser = FirebaseAuth.instance.currentUser;
//   var supervisor;
//   var cosupervisor;

//   String get path => ConvenorPath(firebaseUser!.uid);

//   List get listitem => SupervisorList(firebaseUser!.uid);
  
//   SupervisorList(String value) {
//     List listitem = [];
//     if (value == 'A5Yb79Mx1oYCD4yv6iBVpERJMP33') {
//       return listitem = [
//         "Dr. Abdul Qayyum",
//         "Mr. Shahbaz Ahmad Sahi",
//         "Dr. Rehan Ashraf",
//         "Mr. Waqar Ahmad",
//         "Dr. Toqeer Mehmood",
//         "Ms. Sara Masood"
//       ];
//     } else if (value == 'M0dBC4eOoHgxusWOKP962AlAjs82') {
//       return listitem = [
//         "Dr. Asif Habib",
//         "Mr. Shahbaz Ahmad",
//         "Dr. Suleman Naqvi",
//         "Dr M Hamid",
//         "Dr. Toqeer Mehmood",
//         "Ms. Sara Masood"
//       ];
//     } else if (value == 'mknWkcTTvreOiUPUJdKaWRrBuAG3') {
//       return listitem = [
//         "Mr. M Shahid",
//         "Dr M Adeel",
//         "Dr M Asif",
//         "Mr Arsal Mehmood",
//         "Dr. Toqeer Mehmood",
//         "Ms. Sara Masood"
//       ];
//     }
//   }

//   ConvenorPath(
//     String value,
//   ) {
//     String path = '';

//     if (value == 'A5Yb79Mx1oYCD4yv6iBVpERJMP33') {
//       return path =
//           '/Convenor/classes/BS Information Technology/groups/group-members';
//     } else if (value == 'M0dBC4eOoHgxusWOKP962AlAjs82') {
//       return path =
//           '/Convenor/classes/BS Computer Science/groups/group-members';
//     } else if (value == 'mknWkcTTvreOiUPUJdKaWRrBuAG3') {
//       return path =
//           '/Convenor/classes/BS Software Engineering/groups/group-members';
//     } else {
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Column(children: [
//       Padding(
//         padding: const EdgeInsets.only(left: 150, right: 150),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             const Text(
//               "Main Supervisor",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(
//               width: 30,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(14),
//                   color: const Color.fromARGB(255, 223, 219, 219)),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     left: 14, top: 3, bottom: 3, right: 14),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     focusColor: Colors.grey[200],
//                     hint: const Text(
//                       "Choose Main Supervisor",
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     value: supervisor,
//                     onChanged: (newValue) {
//                       setState(() {
//                         supervisor = newValue;
//                       });
//                     },
//                     items: listitem.map((valueItem) {
//                       return DropdownMenuItem(
//                         value: valueItem,
//                         child: Text(valueItem),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             const Text(
//               "Co Supervisor",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(
//               width: 45,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(14),
//                   color: const Color.fromARGB(255, 223, 219, 219)),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     left: 14, top: 3, bottom: 3, right: 14),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton(
//                     focusColor: Colors.grey[200],
//                     hint: const Text(
//                       "Choose Co-Supervisor",
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     value: cosupervisor,
//                     onChanged: (newValue) {
//                       setState(() {
//                         cosupervisor = newValue;
//                       });
//                     },
//                     items: listitem.map((valueItem) {
//                       return DropdownMenuItem(
//                         value: valueItem,
//                         child: Text(valueItem),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       const SizedBox(
//         height: 30,
//       ),
//       ElevatedButton(
//         onPressed: () {
//           setState(() {
//             showDialog(
//                 context: context,
//                 builder: (ctx) => AlertDialog(
//                       title: const Text(
//                         "Group Registration",
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       actions: <Widget>[
//                         TextButton(
//                           onPressed: () {
//                             var db = FirebaseFirestore.instance
//                                 .collection(path)
//                                 .doc(id)
//                                 .collection('supervisors');

//                             db.add({
//                               "main-supervisor": supervisor,
//                               "co-supervisor": cosupervisor,
//                             });

//                             Navigator.pop(ctx);
//                             // Navigator.push(
//                             //     context,
//                             //     MaterialPageRoute(
//                             //       builder: (context) =>
//                             //           StudentDashboard(),
//                             //     ));
//                           },
//                           child: const Text("OK"),
//                         ),
//                       ],
//                       content: const Text("Successful",
//                           style: TextStyle(
//                               color: Color.fromARGB(255, 20, 107, 23))),
//                     ));
//           });
//         },
//         style: ElevatedButton.styleFrom(
//             primary: const Color.fromARGB(255, 57, 120, 125),
//             padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
//             textStyle:
//                 const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//         child: const Text('Allocate'),
//       ),
//       const SizedBox(
//         height: 20,
//       ),
//       const Divider(
//         height: 10,
//         thickness: 1,
//       ),
//     ]));
//   }
// }
