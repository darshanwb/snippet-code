static void showSettingDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (_){
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context);
              return false;
            },
            child: SimpleDialog(
              contentPadding: EdgeInsets.all(10),
              backgroundColor: colorWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0), // set border radius
                side: BorderSide(color: Colors.grey,width: 1.5), // set border color
              ),
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          navigatePop(context);
                          navigateNameTo(context, AppRoutes.notification);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,horizontal: 20
                            ),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Notification settings",
                              style: textStyleRegular(size: 14, color: colorBlack),
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          navigatePop(context);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,horizontal: 20
                            ),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Terms & Conditions",
                              style: textStyleRegular(size: 14, color: colorBlack),
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          navigatePop(context);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,horizontal: 20
                            ),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "FAQs",
                              style: textStyleRegular(size: 14, color: colorBlack),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
    );
  }
