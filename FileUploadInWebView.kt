//  1). To enable users to upload a file from their device storage through a Google Form displayed in a WebView in your Kotlin Android app

webView.webViewClient = object : WebViewClient() {
    // Handle URL loading within the WebView
    override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
        view?.loadUrl(request?.url.toString())
        return true
    }
}


//  2). Load the Google Form URL in the WebView

val url = "https://docs.google.com/forms/d/e/.../viewform"
webView.loadUrl(url)


//  3). Override the onShowFileChooser() method of your WebViewClient to handle the file upload process:

override fun onShowFileChooser(
    webView: WebView?,
    filePathCallback: ValueCallback<Array<Uri>>?,
    fileChooserParams: FileChooserParams?
): Boolean {
    // Create an intent to open the file picker
    val intent = fileChooserParams?.createIntent()

    // Check if the intent is available and request user permission
    if (intent != null && activity?.packageManager?.resolveActivity(intent, 0) != null) {
        try {
            startActivityForResult(intent, FILE_UPLOAD_REQUEST_CODE)
            mFilePathCallback = filePathCallback
            return true
        } catch (e: Exception) {
            // Handle exception
        }
    }

    return super.onShowFileChooser(webView, filePathCallback, fileChooserParams)
}

//  4). Handle the file upload result in your activity's onActivityResult() method:

override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    super.onActivityResult(requestCode, resultCode, data)

    if (requestCode == FILE_UPLOAD_REQUEST_CODE) {
        if (resultCode == Activity.RESULT_OK && data != null) {
            val uri = data.data
            if (uri != null && mFilePathCallback != null) {
                mFilePathCallback?.onReceiveValue(arrayOf(uri))
                mFilePathCallback = null
            }
        } else {
            mFilePathCallback?.onReceiveValue(null)
            mFilePathCallback = null
        }
    }
}
