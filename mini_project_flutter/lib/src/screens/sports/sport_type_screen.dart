import 'setting/setting.dart';

class SportTypeScreen extends StatefulWidget {
  static const route = '/sport';
  const SportTypeScreen({super.key});

  @override
  State<SportTypeScreen> createState() => _SportTypeScreenState();
}

class _SportTypeScreenState extends State<SportTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.sports_outlined),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('X-Sport'),
      ),
      endDrawer: const DrawerMax(),
      body: Builder(builder: (context) {
        return Consumer<SportViewModel>(
          builder: (context, value, child) {
            switch (value.state) {
              case ActionState.loading:
                return const LoadingMax();

              case ActionState.none:
                return ListSports(sports: value.sports);

              case ActionState.error:
                return const ErrorMax();
            }
          },
        );
      }),
    );
  }
}
