import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:atef_physics/core/widgets/custom_appdrawer.dart';
import 'package:atef_physics/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:atef_physics/core/utils/user_type_enum.dart';
import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/features/users/presentation/cubit/user_cubit.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});
  static const String id = "/UsersScreen";

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomAppdrawer(),
      appBar: CustomAppBars(
        text: "Atef Physics",
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              backgroundImage: AssetImage(Assets.images.icon.path),
              radius: 20,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search by name or phone number',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocConsumer<UserCubit, UserState>(
                listener: (context, state) => state.whenOrNull<void>(
                  successAll: (models) => users = List.from(models),
                  remove: (model) =>
                      users.removeWhere((test) => test.uid == model.uid),
                  error: (error) => error.showError(context),
                  update: (user, update) {
                    AppSnackBar.showSnackBar(
                        context, "${user.name}\n $update updated");
                    final e = users.indexWhere((e) => e.uid == user.uid);
                    users[e] = user;
                  },
                ),
                builder: (context, state) {
                  final filteredUsers = users.where((user) {
                    return user.name.toLowerCase().contains(_searchQuery) ||
                        user.phoneNumber.toLowerCase().contains(_searchQuery);
                  }).toList();

                  return state.maybeMap<Widget>(
                      load: (_) =>
                          const Center(child: CircularProgressIndicator()),
                      orElse: () => filteredUsers.isEmpty
                          ? const Center(child: Text('No users available'))
                          : ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Padding(
                                padding: EdgeInsets.all(8),
                                child: Divider(),
                              ),
                              itemCount: filteredUsers.length,
                              itemBuilder: (context, index) {
                                final item = filteredUsers[index];
                                return ListTile(
                                  leading: GestureDetector(
                                    onTap: () async {
                                      if (item.userType == UserTypeEnum.admin) {
                                        await BlocProvider.of<UserCubit>(
                                                context)
                                            .updateUser(
                                                user: item,
                                                update: "user",
                                                userTypeEnum:
                                                    UserTypeEnum.user);
                                      } else {
                                        await BlocProvider.of<UserCubit>(
                                                context)
                                            .updateUser(
                                                user: item,
                                                update: "admin",
                                                userTypeEnum:
                                                    UserTypeEnum.admin);
                                      }
                                    },
                                    child: item.userType == UserTypeEnum.admin
                                        ? Assets.images.icons.adminWithCogwheels
                                            .image(
                                            color: Colors.blue,
                                          )
                                        : Assets.images.icons.user.image(
                                            color: Colors.blue,
                                          ),
                                  ),
                                  title: Text(item.name),
                                  subtitle: Text(item.phoneNumber),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            AppSnackBar.showConfirmDialog(
                                                context: context,
                                                fun: () => BlocProvider.of<
                                                        UserCubit>(context)
                                                    .updateUser(
                                                        update:
                                                            "Removed Devices",
                                                        user: item,
                                                        fcmToken: ""),
                                                lable:
                                                    "Remove user ${item.name} Device?"),
                                        icon: const Icon(
                                          Icons.logout_rounded,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            AppSnackBar.showConfirmDialog(
                                          context: context,
                                          lable: "Remove User ? ",
                                          fun: () => BlocProvider.of<UserCubit>(
                                                  context)
                                              .removeUser(item),
                                        ),
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
