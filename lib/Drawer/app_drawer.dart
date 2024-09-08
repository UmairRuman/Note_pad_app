import 'package:flutter/material.dart';
import 'package:simple_notes_app/Drawer/favouriteNotes.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Umair Ruman"),
            accountEmail: const Text("Programmerumair29@gmail.com"),
            currentAccountPicture: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: const CircleBorder(), //this right here
                        child: Container(
                          height: 300,
                          child: const CircleAvatar(
                              foregroundImage:
                                  AssetImage("assets/images/mypic.jpg")),
                        ),
                      );
                    });
              },
              child: const CircleAvatar(
                  foregroundImage: AssetImage("assets/images/mypic.jpg")),
            ),
            decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage("assets/images/blue.jpg"),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favourite"),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const FavouriteNotes();
                },
              ))
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text("Profile"),
            onTap: () => {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Clicked on Profile")))
            },
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text("Messages"),
            onTap: () => {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Clicked on Messages")))
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text("Share"),
            onTap: () => {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Clicked on Share")))
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            onTap: () => {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Clicked on Notifications")))
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Setting"),
            onTap: () => {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Clicked on Settings")))
            },
          ),
          ListTile(
            leading: const Icon(Icons.power_settings_new_outlined),
            title: const Text("Sign out"),
            onTap: () => {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Clicked on Sign out")))
            },
          ),
        ],
      ),
    );
  }
}
