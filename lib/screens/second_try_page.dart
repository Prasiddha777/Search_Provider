import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_api/providers/pets_provider.dart';
import 'package:search_api/providers/user_provider.dart';

class SecondTryPage extends StatefulWidget {
  const SecondTryPage({super.key});

  @override
  State<SecondTryPage> createState() => _SecondTryPageState();
}

class _SecondTryPageState extends State<SecondTryPage> {
  @override
  void initState() {
    // TODO: implement initState
    final provider = Provider.of<UserProvider>(context, listen: false);
    provider.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider API CALL'),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? CircularProgressIndicator()
          : provider.error.isNotEmpty
              ? Text(provider.error)
              : getBodyUI(),
    );
  }

  //get Body UI
  Widget getBodyUI() {
    final provider = Provider.of<UserProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(7),
            child: TextField(
              onChanged: (value) {
                provider.search(value);
              },
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          //
          Consumer(
            builder: (context, UserProvider userValue, child) {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: userValue.searchUserModel.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(userValue
                          .searchUserModel.data![index].avatar
                          .toString()),
                    ),
                    title: Text(userValue.searchUserModel.data![index].firstName
                        .toString()),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
