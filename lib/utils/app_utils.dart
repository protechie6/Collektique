import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../models/my_library_model.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:permission_handler/permission_handler.dart';
import 'ui_utils.dart';

class AppUtils {
  static final isLoading = ValueNotifier<bool>(false);

  /*static Future<bool> createFolderAndSave(String imagePath) async {
      Directory? directory;
      try{
        if(Platform.isAndroid){
          //android platform
          if(await _requestPermission(Permission.storage)){
            directory= await getExternalStorageDirectory();
            String path = '';
            List<String> folders = directory!.path.split('/');
            for(int x=1; x<folders.length; x++){
              String folder = folders[x];
              if(folder != 'Android'){
                path+='/$folder';
              }else{
                break;
              }
            }
            path='$path/DCIM/Camera/';
            directory = Directory(path);

          }
        }else{

          ////TODO  IOS platform
          if(await _requestPermission(Permission.photos)){}
        }
        if(await directory!.exists()){
          return await compute(saveImageFile,{'imagePath': imagePath,
          'dir':directory.path}); 
        }else{
          await directory.create(recursive: true).then((value) async => 
          await compute(saveImageFile,{'imagePath': imagePath,
          'dir':directory!.path}));
          return false;
        }
      }catch(err){
        print(err);
        return false;
      }
  }*/

  static Future<bool> _requestPermission(Permission permission)async{
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        isLoading.value = false;
        return false;
      }
    }
  }

  static Future<void> openDocument(MyLibraryModel itemDetails, String extras,
      String url, String insurerEmail, BuildContext context) async {
    Directory? directory;
    isLoading.value = true;
    try {
      if (Platform.isAndroid) {
        //android platform
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String path = '';
          List<String> folders = directory!.path.split('/');
          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != 'Android') {
              path += '/$folder';
            } else {
              break;
            }
          }
          path = '$path/Watch vault/Stolen Items';
          directory = Directory(path);
        }
      } else {
        ////TODO  IOS platform
        //if(await _requestPermission(Permission.photos)){}
      }
      //check if pdf file exist
      if (await File('${directory!.path}/$extras').exists()) {
        // mail the file to the company
        // ignore: use_build_context_synchronously
        sendEmail(insurerEmail, context, '${directory.path}/$extras');
      } else {
        // create the file and mail
        await directory.create(recursive: true).then((value) async =>
            await compute(_downloadFile, {'url': url, 'dir': value.path})
                .then((value) {
              if (value != null) {
                // create the pdf and save with the given extras then mail
                pdfDoc('${directory!.path}/$extras', itemDetails, insurerEmail,
                    context);
              } else {
                isLoading.value = false;
              }
            }));
      }
    } catch (err) {
      isLoading.value = false;
      UiUtils.customSnackBar(context, msg: 'Failed: ${err.toString()}');
    }
  }

  static Future<void> pdfDoc(String fileName, MyLibraryModel itemDetails,
      String insurerEmail, BuildContext context) async {
    final pdf = pw.Document();

    pw.Widget productDetails() {
      return pw.Container(
        margin: const pw.EdgeInsets.only(
          left: 20,
          top: 20,
        ),
        child: pw.Text("Item details"),
      );
    }

    pw.Widget brand() {
      return pw.Container(
        margin: const pw.EdgeInsets.only(
          top: 10,
          left: 20,
        ),
        child: pw.Text(
          "Brand: ${itemDetails.brand}",
        ),
      );
    }

    pw.Widget model() {
      return pw.Container(
        margin: const pw.EdgeInsets.only(
          top: 10,
          left: 20,
        ),
        child: pw.Text(
          "Model: ${itemDetails.model}",
        ),
      );
    }

    pw.Widget serialNumber() {
      return pw.Container(
        margin: const pw.EdgeInsets.only(
          top: 10,
          left: 20,
        ),
        child: pw.Text(
          "Serial Number: ${itemDetails.serialNumber}",
        ),
      );
    }

    pw.Widget year() {
      return pw.Container(
        margin: const pw.EdgeInsets.only(
          top: 10,
          left: 20,
        ),
        child: pw.Text(
          "Year: ${itemDetails.year}",
        ),
      );
    }

    pw.Widget boxAndPapers() {
      return pw.Container(
          margin: const pw.EdgeInsets.only(
            top: 10,
            left: 20,
          ),
          child: pw.Text(
            "Box and Papers: ${itemDetails.boxAndPapers.length} image(s)",
          ));
    }

    pw.Widget insured() {
      return pw.Container(
          margin: const pw.EdgeInsets.only(
            top: 10,
            left: 20,
          ),
          child: pw.Text(
            "Insured: ${itemDetails.insured}",
          ));
    }

    pw.Widget serviceRecords() {
      return pw.Container(
        margin: const pw.EdgeInsets.only(
          top: 10,
          left: 20,
        ),
        child: pw.Text(
          "Service Records: ${itemDetails.serviceRecord.length} image(s)",
        ),
      );
    }

    pw.Widget ownedFor() {
      return pw.Container(
        margin: const pw.EdgeInsets.only(
          top: 10,
          left: 20,
        ),
        child: pw.Text(
          "Owned For: ${itemDetails.ownedFor}",
        ),
      );
    }

    pw.Widget forSale() {
      return pw.Container(
        margin: const pw.EdgeInsets.only(
          top: 10,
          left: 20,
        ),
        child: pw.Text(
          "For Sale: ${itemDetails.forSale}",
        ),
      );
    }

    pw.Widget price() {
      return pw.Container(
        margin: const pw.EdgeInsets.only(
          top: 10,
          left: 20,
        ),
        child: pw.Text(
          "Price: ${itemDetails.price}",
        ),
      );
    }

    pw.Widget body() {
      return pw.Column(
        children: [
          pw.Header(child: pw.Text('Stolen item')),
          productDetails(),
          brand(),
          model(),
          serialNumber(),
          year(),
          boxAndPapers(),
          insured(),
          serviceRecords(),
          ownedFor(),
          forSale(),
          price(),
        ],
      );
    }

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return body(); // Center
        }));

    final bytes = await pdf.save();
    final file = File(fileName);
    await file
        .writeAsBytes(bytes)
        .then((value) => sendEmail(insurerEmail, context, value.path));
  }

  static void sendEmail(
      String insurerEmail, BuildContext context, String filePath) async {
    final Email email = Email(
      body:'Hi there! My Watch has been stolen. You will find attached, the watch details below. Thank you.',
      subject: 'Stolen watch',
      recipients: [insurerEmail],
      attachmentPaths: [filePath],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email)
          .then((value) => isLoading.value = false);
    } catch (error) {
      UiUtils.customSnackBar(context, msg: error.toString());
      isLoading.value = false;
    }
  }
}

Future<File?> _downloadFile(Map map) async {
// download the image from the given url
  String dir = map['dir'];
  String url = map['url'];

  HttpClient httpClient = HttpClient();
  try {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      var bytes = await consolidateHttpClientResponseBytes(response);
      File file = File('$dir/IMG${DateTime.now()}.jpeg');
      await file.writeAsBytes(bytes);
      return file;
    } else {
      return null;
    }
  } catch (error) {
    print('pdf saving error = $error');
    return null;
  }
}
