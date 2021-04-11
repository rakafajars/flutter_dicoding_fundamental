import 'package:flutter/cupertino.dart';

class FeedsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Search Page'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Feeds Page',
              style:
                  CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
            ),
            SizedBox(height: 8),
            CupertinoButton.filled(
              child: Text('Select Category'),
              onPressed: () {
                _modalPopup(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _modalPopup(
    BuildContext context,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: Text('Select Categorres'),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) =>
                        CategoryPage(selectedCategory: 'Technology'),
                  ),
                );
              },
              child: Text('Technology'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) =>
                        CategoryPage(selectedCategory: 'Business'),
                  ),
                );
              },
              child: Text('Business'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) =>
                        CategoryPage(selectedCategory: 'Sport'),
                  ),
                );
              },
              child: Text('Sport'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Close'),
            onPressed: () => Navigator.pop(context),
          ),
        );
      },
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String selectedCategory;

  CategoryPage({@required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('$selectedCategory Page'),
      ),
      child: Center(
        child: Text(
          '$selectedCategory Page',
          style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
        ),
      ),
    );
  }
}
