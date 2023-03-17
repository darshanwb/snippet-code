override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
 
        // on below line we are
        // initializing our media player
        mediaPlayer = MediaPlayer()
        
        var audioUrl = "https://samplelib.com/lib/preview/mp3/sample-3s.mp3"
        mediaPlayer.setDataSource(audioUrl)
        
        mediaPlayer.prepare()
        mediaPlayer.start()
        //mediaPlayer.stop()
}
