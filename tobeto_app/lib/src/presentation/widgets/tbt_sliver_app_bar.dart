import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/common/enums/user_rank_enum.dart';

import '../../blocs/auth/auth_bloc.dart';

class TBTSliverAppBar extends StatelessWidget {
  final PreferredSizeWidget? bottom;
  const TBTSliverAppBar({
    super.key,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      centerTitle: true,
      floating: true,
      snap: true,
      bottom: bottom,
      title: Image.asset(
        Assets.imagesTobetoLogo,
        width: 200,
      ),
      actions: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated &&
                (state.userModel.userRank == UserRank.admin ||
                    state.userModel.userRank == UserRank.instructor)) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: Icon(
                  state.userModel.userRank == UserRank.admin
                      ? Icons.admin_panel_settings_outlined
                      : Icons.menu_book_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    );
  }
}
