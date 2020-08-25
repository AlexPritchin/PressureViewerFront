import 'dart:ui' as ui;
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

import '../resources/constants.dart';
import '../providers/main_provider.dart';
import '../widgets/file_list/file_list_item.dart';
import '../widgets/file_list/file_list_dropdown_menu_item.dart';

class FileListScreen extends StatefulWidget {
  bool isFileBeingAdded = false;
  SortOrderType currentDateSortOrder = SortOrderType.Descending;

  @override
  _FileListScreenState createState() => _FileListScreenState();
}

class _FileListScreenState extends State<FileListScreen> {
  void pickFile(BuildContext mainContext) async {
    var networkConnectionExists = await Connectivity().checkConnectivity();
    if (networkConnectionExists == ConnectivityResult.none) {
      Scaffold.of(mainContext).showSnackBar(
        SnackBar(
          content: Text(
            Errors.noNetworkError,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      );
      return;
    }
    final File pickedFile = await FilePicker.getFile(
        type: FileType.custom, allowedExtensions: [csvFileExtension]);
    print(pickedFile.path);
    final isFileExistsInBase =
        Provider.of<MainProvider>(mainContext, listen: false)
            .checkFileNameIsInFileEntriesList(byPath: pickedFile.path);
    if (isFileExistsInBase) {
      showDialog<void>(
          context: mainContext,
          barrierDismissible: false,
          builder: (ctx) {
            return AlertDialog(
              title: Text(AlertTitles.error),
              content: Text(Errors.fileListFileAlreadyExists),
              actions: <Widget>[
                FlatButton(
                  child: Text(ButtonsTitles.ok),
                  onPressed: () {
                    Navigator.of(mainContext).pop();
                  },
                )
              ],
            );
          });
      return;
    }
    setState(() {
      widget.isFileBeingAdded = true;
    });
    var isFileAdded = await Provider.of<MainProvider>(mainContext, listen: false)
        .addFile(fileToAdd: pickedFile);
    setState(() {
      widget.isFileBeingAdded = false;
    });
    if (!isFileAdded) {
      Scaffold.of(mainContext).showSnackBar(
          SnackBar(
            content: Text(
              Errors.unknownError,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        );
    }
  }

  void sortFileEntries(
      BuildContext mainContext, SortOrderType chosenSortOrder) {
    if (chosenSortOrder != widget.currentDateSortOrder) {
      widget.currentDateSortOrder = chosenSortOrder;
      Provider.of<MainProvider>(mainContext, listen: false)
          .sortFileEntries(chosenSortOrder);
    }
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = ui.window.locale;
    print(myLocale.countryCode);
    print(myLocale.languageCode);
    Intl.defaultLocale = '${myLocale.languageCode}_${myLocale.countryCode}';
    initializeDateFormatting();
    final mainProvid = Provider.of<MainProvider>(context);
    ScrollController scrollToAddedItemScrollControler = ScrollController(
        initialScrollOffset: 70 * mainProvid.addedFileEntryIndex.toDouble());
    return Scaffold(
        appBar: AppBar(
          title: Text(ScreensTitles.fileListScreenTitle),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DropdownButton(
                  underline: Container(),
                  icon: Icon(
                    Icons.sort,
                    color: Colors.white,
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        DropdownMenuTitles.sort,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: 'title',
                    ),
                    DropdownMenuItem(
                      child: FileListDropdownMenuItem(
                        DropdownMenuTitles.ascending,
                        widget.currentDateSortOrder == SortOrderType.Ascending,
                      ),
                      value: 'Asc',
                    ),
                    DropdownMenuItem(
                      child: FileListDropdownMenuItem(
                        DropdownMenuTitles.descending,
                        widget.currentDateSortOrder == SortOrderType.Descending,
                      ),
                      value: 'Desc',
                    ),
                  ],
                  onChanged: (itemIdentifier) {
                    if (itemIdentifier == 'Asc') {
                      sortFileEntries(context, SortOrderType.Ascending);
                    } else if (itemIdentifier == 'Desc') {
                      sortFileEntries(context, SortOrderType.Descending);
                    }
                  },
                ),
              ],
            ),
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  pickFile(context);
                })
          ],
        ),
        body: widget.isFileBeingAdded
            ? Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder(
                future: Connectivity().checkConnectivity(),
                builder: (ctx, snapshot) => snapshot.connectionState ==
                        ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : snapshot.data == null
                        ? Center(
                            child: Text(
                              Errors.unknownError,
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : (snapshot.data as ConnectivityResult) ==
                                ConnectivityResult.none
                            ? Center(
                                child: Text(
                                  Errors.noNetworkError,
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : FutureBuilder(
                                future: mainProvid.fetchFileEntries(),
                                builder: (ctx, snapshot) => snapshot
                                            .connectionState ==
                                        ConnectionState.waiting
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : (snapshot.data != null &&
                                            snapshot.data.length > 0)
                                        ? ListView.builder(
                                            itemBuilder: (ctx, elementIndex) =>
                                                FileListItem(
                                              id: snapshot
                                                  .data[elementIndex].id,
                                            ),
                                            itemCount: snapshot.data.length,
                                            controller:
                                                scrollToAddedItemScrollControler,
                                          )
                                        : Center(
                                            child: Text(
                                              snapshot.data != null
                                                  ? Messages
                                                      .fileListNoFilesMessage
                                                  : Errors.unknownError,
                                              style: TextStyle(
                                                  color: snapshot.data != null
                                                      ? Colors.black
                                                      : Colors.red),
                                            ),
                                          ),
                              ),
              ));
  }
}
