import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapi_bloc/blocs/app_blocs.dart';
import 'package:restapi_bloc/blocs/app_events.dart';
import 'package:restapi_bloc/blocs/app_states.dart';
import 'package:restapi_bloc/detail_screen.dart';
import 'package:restapi_bloc/models/user_model.dart';
import 'package:restapi_bloc/repos/repositories.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<UserRepository>(context),
      )..add(LoadUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('test'),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserLoadedState) {
              List<UserModel> userList = state.users;

              return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(e: userList[index]),
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(userList[index].firstname),
                          subtitle: Text(userList[index].lastname),
                          trailing: CircleAvatar(
                            backgroundImage:
                                NetworkImage(userList[index].avatar),
                          ),
                        ),
                      ),
                    );
                  });
            }

            if (state is UserErrorState) {
              return const Center(
                child: Text("Error endpoint"),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
