part of 'home.dart';

const _iconSize = 24.0;
const _emailSize = 16.0;

class HomeDesktop extends StatelessWidget {
  const HomeDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [_title(context)]),
        actions: [_myWorkButton(), w16, _themeSwitchButton(), w16],
      ),
      body: SafeArea(child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: SizedBox.expand(
                child: SingleChildScrollView(padding: const EdgeInsets.only(top: 96), child: _content(context)),
              ),
            ),
            _footer(),
          ],
        ),
        Positioned(left: 0, top: 0, bottom: 0, child: _left(context)),
        Positioned(right: 0, top: 0, bottom: 0, child: _right(context)),
      ],
    );
  }

  Widget _left(BuildContext context) => SizedBox(
    width: 100,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
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
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(height: 100, width: 2, color: context.colorScheme.primary),
            ),
          ].animatedSideBarItem().animatedSideBar(),
    ),
  );

  Widget _right(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children:
            [
              HoverWidget(
                transformOffset: const Offset(0, 10.0),
                child: RotatedBox(
                  quarterTurns: 45,
                  child: Text(
                    "nghai89@gmail.com",
                    style: TextStyle(
                      color: context.colorScheme.primary,
                      letterSpacing: 3.0,
                      fontWeight: FontWeight.w700,
                      fontSize: _emailSize,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(height: 50, width: 2, color: context.colorScheme.primary),
              ),
            ].animatedSideBar(),
      ),
    );
  }
}
