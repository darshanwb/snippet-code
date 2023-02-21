private fun saveImageToInternalStorage(bitmap: Bitmap):Uri{
  
        var file=File(requireActivity().getExternalFilesDir(Environment.DIRECTORY_PICTURES), "photo.jpg")

        try {
            val stream: OutputStream = FileOutputStream(file)
            bitmap.compress(Bitmap.CompressFormat.JPEG,100,stream)
            stream.flush()
            stream.close()
        }catch (e: IOException){
            e.printStackTrace()
        }
        
        return Uri.parse(file.absolutePath +File.separator +bitmap)
    }
