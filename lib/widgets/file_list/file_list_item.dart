import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
import 'package:connectivity/connectivity.dart';

import '../../resources/constants.dart';
import '../../models/file_entry.dart';
import '../../providers/main_provider.dart';
import '../../helpers/alerts_helper.dart';

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
            onPressed: () {
              tryDeleteFileEntry(context);
            },
          ),
          FlatButton(
            child: Text(ButtonsTitles.no),
            onPressed: () => Navigator.of(ctx).pop(false),
          ),
        ],
      ),
    );
  }

  tryDeleteFileEntry(BuildContext context) async {
    var networkConnectionExists = await Connectivity().checkConnectivity();
    if (networkConnectionExists == ConnectivityResult.none) {
      return;
    }
    var mainProvid = Provider.of<MainProvider>(context, listen: false);
    var isFileDeleted = await mainProvid.deleteFileEntry(byId: id);
    Navigator.of(context).pop(isFileDeleted);
    if (!isFileDeleted) {
      AlertsHelper.showSnackBarError(context, Errors.unknownError);
    }
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
