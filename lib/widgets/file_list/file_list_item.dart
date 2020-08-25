import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';

import '../../resources/constants.dart';
import '../../models/file_entry.dart';
import '../../providers/main_provider.dart';

class FileListItem extends StatelessWidget {
  final String id;
  FileEntry fileEntryToShow;

  FileListItem({this.id});

  Future<bool> showConfirmDeleteDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AlertTitles.areYouSure),
        content: Text(Messages.confirmDeleteFileMessage),
        actions: <Widget>[
          FlatButton(
            child: Text(ButtonsTitles.yes),
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
          FlatButton(
            child: Text(ButtonsTitles.no),
            onPressed: () => Navigator.of(ctx).pop(false),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(Intl.defaultLocale);
    print(Intl.systemLocale);
    final dateTimeFormatter = DateFormat.yMd().add_jm();
    print(dateTimeFormatter.locale);
    final mainProvid = Provider.of<MainProvider>(context, listen: false);
    fileEntryToShow = mainProvid.getFileEntry(byId: id);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 20,
        ),
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 5,
        ),
        padding: EdgeInsets.only(right: 7),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => showConfirmDeleteDialog(context),
      onDismissed: (_) => mainProvid.deleteFileEntry(byId: id),
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                dateTimeFormatter.format(fileEntryToShow.dateModified),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(path.basenameWithoutExtension(fileEntryToShow.fileName))
              ]),
          onTap: () {
            Navigator.of(context).pushNamed(
                ScreensRoutesNames.fileDetailsScreenRoute,
                arguments: id);
          },
        ),
      ),
    );
  }
}
