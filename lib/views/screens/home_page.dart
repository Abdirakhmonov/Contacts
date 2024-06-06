import 'package:flutter/material.dart';
import 'package:homework_52/services/localdatabase.dart';

import '../../models/contact_model.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final localDatabase = LocalDatabase();
  List contactList = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localDatabase.database;
  }

  addContactDialog(Contact? contact) {
    final _nameController = TextEditingController(text: contact?.name ?? '');
    final _phoneController = TextEditingController(text: contact?.phone ?? '');
    final _imageController = TextEditingController(text: contact?.image ?? '');
     showDialog(
        context: context,
        builder: (BuildContext contect) {
          return AlertDialog(
            title: Text(contact == null ? 'Add Contact' : 'Edit Contact'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                ),
                TextField(
                  controller: _imageController,
                  decoration: const InputDecoration(labelText: 'Image Path'),
                ),
              ],
            ),
            //       actions: [
            //   TextButton(
            //     onPressed: () async {
            //       final String name = _nameController.text.trim();
            //       final String phone = _phoneController.text.trim();
            //       final String? imagePath = _imageController.text.trim().isEmpty
            //           ? null
            //           : _imageController.text.trim();
            //
            //       if (contact == null) {
            //         final newContact =
            //             Contact(name: name, phone: phone, image: imagePath);
            //         await dbHelper.insertContact(newContact);
            //       } else {
            //         final updatedContact = Contact(
            //             id: contact.id,
            //             name: name,
            //             phone: phone,
            //             image: imagePath);
            //         await dbHelper.updateContact(updatedContact);
            //       }
            //
            //       _updateContactList();
            //       Navigator.of(context).pop();
            //     },
            //     child: const Text('Save'),
            //   ),
            //   TextButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     child: const Text('Cancel'),
            //   ),
            // ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemBuilder: (context, index) {
                return ListTile();
              },
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(),
              ),
              itemCount: contactList.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.add),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// import '../../localdatabase/localdatabase.dart';
// import '../../models/contact_model.dart';
//
// class ContactListScreen extends StatefulWidget {
//   const ContactListScreen({super.key});
//
//   @override
//   _ContactListScreenState createState() => _ContactListScreenState();
// }
//
// class _ContactListScreenState extends State<ContactListScreen> {
//   DatabaseHelper dbHelper = DatabaseHelper.instance;
//   List<Contact> contactList = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _updateContactList();
//   }
//
//   _updateContactList() async {
//     final List<Contact> contacts = await _getContactList();
//     setState(() {
//       contactList = contacts;
//       isLoading = false;
//     });
//   }
//
//   Future<List<Contact>> _getContactList() async {
//     final List<Map<String, dynamic>> contactMapList =
//         await dbHelper.getContactMapList();
//     final List<Contact> contacts = contactMapList
//         .map((contactMap) => Contact.fromMap(contactMap))
//         .toList();
//     return contacts;
//   }
//
//   _deleteContact(Contact contact) async {
//     await dbHelper.deleteContact(contact.id!);
//     _updateContactList();
//   }
//
//   _showForm(Contact? contact) {
//     final _nameController = TextEditingController(text: contact?.name ?? '');
//     final _phoneController = TextEditingController(text: contact?.phone ?? '');
//     final _imageController =
//         TextEditingController(text: contact?.imagePath ?? '');
//
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text(contact == null ? 'Add Contact' : 'Edit Contact'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _phoneController,
//               decoration: const InputDecoration(labelText: 'Phone'),
//             ),
//             TextField(
//               controller: _imageController,
//               decoration: const InputDecoration(labelText: 'Image Path'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               final String name = _nameController.text.trim();
//               final String phone = _phoneController.text.trim();
//               final String? imagePath = _imageController.text.trim().isEmpty
//                   ? null
//                   : _imageController.text.trim();
//
//               if (contact == null) {
//                 final newContact =
//                     Contact(name: name, phone: phone, imagePath: imagePath);
//                 await dbHelper.insertContact(newContact);
//               } else {
//                 final updatedContact = Contact(
//                     id: contact.id,
//                     name: name,
//                     phone: phone,
//                     imagePath: imagePath);
//                 await dbHelper.updateContact(updatedContact);
//               }
//
//               _updateContactList();
//               Navigator.of(context).pop();
//             },
//             child: const Text('Save'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('Cancel'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContactImage(Contact contact) {
//     if (contact.imagePath != null && contact.imagePath!.isNotEmpty) {
//       return CircleAvatar(
//         backgroundImage: AssetImage(contact.imagePath!),
//       );
//     } else {
//       return CircleAvatar(
//         child: Text(contact.name[0]),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Contacts',style: TextStyle(
//           fontSize: 22,
//           fontWeight: FontWeight.bold
//         ),),
//         centerTitle: true,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.separated(
//         separatorBuilder: (context, index){
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Divider(),
//           );
//         },
//               itemCount: contactList.length,
//               itemBuilder: (context, index) {
//                 final contact = contactList[index];
//                 return ListTile(
//                   leading: _buildContactImage(contact),
//                   title: Text(contact.name),
//                   subtitle: Text(contact.phone),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.edit),
//                         onPressed: () => _showForm(contact),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.delete),
//                         onPressed: () => _deleteContact(contact),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showForm(null),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
