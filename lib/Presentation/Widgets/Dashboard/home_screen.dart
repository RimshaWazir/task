import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy/Application/Services/ApiServices/apis.dart';
import 'package:dummy/Data/DataSource/Resources/gap.dart';
import 'package:dummy/Presentation/Widgets/Auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../Data/DataSource/Dialogs/dialogs.dart';
import '../../../Domain/AuthModel/chat_user.dart';
import '../../Commons/chat_user_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<ChatUser> _list = [];
  List<ChatUser> _searchList = [];
  final bool _isSearching = false;
  ChatUser? user;
  @override
  void initState() {
    super.initState();
    count();
    _fetchUsers();
  }

  Future<int> count() async {
    int unreadCount = await APIsService.fetchUnreadMessageCount(user!);
    log(unreadCount.toString());
    return unreadCount;
  }

  Future<void> _fetchUsers() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      setState(() {
        _list = snapshot.docs
            .map((doc) => ChatUser.fromJson(doc.data()))
            .where((user) => user.id != APIsService.user.uid)
            .toList();
      });
    } catch (e) {
      // Handle error
      print('Error fetching users: $e');
    }
  }

  void _searchUsers(String query) {
    _searchList.clear();
    if (query.isEmpty) {
      setState(() {
        _searchList = [];
        _searchList.clear();
      });
      return;
    }
    setState(() {
      _searchList = _list
          .where((user) =>
              user.name.toLowerCase().contains(query.toLowerCase()) ||
              user.email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 200,
          automaticallyImplyLeading: false,
          title: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Gap.horizontalSpace(10),
                const Icon(CupertinoIcons.search),
                Gap.horizontalSpace(10),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search...',
                    ),
                    autofocus: true,
                    style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
                    onChanged: (query) => _searchUsers(query),
                  ),
                ),
                const Icon(Icons.filter_alt),
                Gap.horizontalSpace(10),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                //for showing progress dialog
                Dialogs.showProgressBar(context);
                await APIsService.updateActiveStatus(false);
                //sign out from app
                await APIsService.auth.signOut().then((value) async {
                  await GoogleSignIn().signOut().then((value) {
                    APIsService.auth = FirebaseAuth.instance;

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()));
                  });
                });
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: _list.isNotEmpty
            ? ListView.builder(
                itemCount: _isSearching ? _searchList.length : _list.length,
                itemBuilder: (context, index) {
                  final user = _isSearching ? _searchList[index] : _list[index];
                  return ChatUserCard(user: user);
                },
              )
            : const Center(
                child: Text('No Users Found!', style: TextStyle(fontSize: 20)),
              ),
      ),
    );
  }
}
