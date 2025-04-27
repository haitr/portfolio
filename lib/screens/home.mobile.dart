part of 'home.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [_myWorkButton(), w16, _themeSwitchButton(), w16],
        title: Text('<Howard>', style: context.textTheme.displaySmall!.copyWith(color: context.colorScheme.primary)),
      ),
      body: SafeArea(child: Column(children: [Expanded(child: _buildBody(context)), _bottom(context)])),
      backgroundColor: context.colorScheme.surface,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(padding: const EdgeInsets.only(top: 96), child: _content(context)),
    );
  }

  Widget _bottom(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    width: double.infinity,
    height: 100,
    child: Row(
      spacing: 24,
      children:
          [
            IconButton(
              icon: FaIcon(FontAwesomeIcons.github),
              color: context.colorScheme.primary,
              iconSize: _iconSize,
              onPressed: () => openUrl("https://github.com/haitr"),
            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.linkedin),
              color: context.colorScheme.primary,
              onPressed: () => openUrl("https://www.linkedin.com/in/haing22/"),
              iconSize: _iconSize,
            ),
            IconButton(
              icon: Icon(Icons.mail),
              color: context.colorScheme.primary,
              iconSize: _iconSize,
              onPressed: () => launchEmail('nghai89@gmail.com'),
            ),
            Spacer(),
            _title(context),
          ].animatedSideBar(),
    ),
  );
}
