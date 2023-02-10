//  Here's a reusable function that converts an image to a Base64 string in Kotlin

/*
The Image to convert in base64 string repository is a Python project that allows you to easily convert images into base64 encoded strings. 
Use it as a standalone tool or integrate it into your existing projects. 
Includes source code and documentation.

In this code, the input bitmap is first compressed into a ByteArrayOutputStream using the compress method. 
Then, the toByteArray method is used to convert the ByteArrayOutputStream to a byteArray. 
And Finally, the Base64.encodeToString method is used to encode the byteArray into a Base64 string, which is returned as the function's result.
*/

fun imageToBase64(bitmap: Bitmap): String {
    val byteOutputStream = ByteArrayOutputStream()
    bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteOutputStream)
    val byteArray = byteOutputStream.toByteArray()
    return Base64.encodeToString(byteArray, Base64.DEFAULT)
}
