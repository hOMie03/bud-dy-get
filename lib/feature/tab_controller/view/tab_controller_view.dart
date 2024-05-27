part of '../viewmodel/tab_controller_viewmodel.dart';

class TabControllerView extends StatefulWidget {
  const TabControllerView({Key? key}) : super(key: key);

  @override
  State<TabControllerView> createState() => _TabControllerViewState();
}

class _TabControllerViewState extends TabControllerViewModel {

  var isLogoutLoading = false;

  logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => LoginView())));

    setState(() {
      isLogoutLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _appBar(context),
      body: pages[currentIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(AppPaddings.padding15.padding),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.radius40.radius),
          child: _bottomNavAppBar(),
        ),
      ),
    );
  }

  BottomNavigationBar _bottomNavAppBar() {
    return BottomNavigationBar(
      items: navBarItems,
      currentIndex: currentIndex,
      onTap: (value) {
        setState(() {
          currentIndex = value;
        });
      },
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(AppConstants.getInstance.appTitle),
      actions: [
        IconButton(
            onPressed: () {
              logOut();
            },
            icon:
            isLogoutLoading ? CircularProgressIndicator()
                :Icon(Icons.exit_to_app))
      ],
    );
  }



}
