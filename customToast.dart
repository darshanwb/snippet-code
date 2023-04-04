void showToast(String toastMsg) {
  Fluttertoast.showToast(
      msg: "$toastMsg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0

  );
}
