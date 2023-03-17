fun void main(){
  val soundUrl="https://samplelib.com/lib/preview/mp3/sample-6s.mp3"
  val filename = "sample_tone.mp3"
  val dir = File(requireActivity().filesDir.path + "/sound")
  val soundfile= File(dir,filename)
  downloadIntroAudio(soundUrl,dir.path,filename)
}

fun downloadIntroAudio(url: String, dirPath: String, filename: String) {
        PRDownloader.download(
            url,
            dirPath,
            filename
        ).build()
            .start(object : OnDownloadListener {
                override fun onDownloadComplete() {
                    printMsg("Audio download complete")
                }

                override fun onError(error: com.downloader.Error?) {
                    printMsg("Audio download error ${error?.connectionException}")
                }
       })
 }
