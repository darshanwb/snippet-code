    
//    1). Define an interface in your adapter class that will allow the activity to receive the ID of the clicked image. 
  
interface OnItemClickListener {
    fun onItemClick(imageId: Int)
}

    
//    2). Add a listener property to your adapter class that will hold an instance of the OnItemClickListener interface. 

class ImageAdapter(private val images: List<Int>, private val listener: OnItemClickListener) :
    RecyclerView.Adapter<ImageAdapter.ImageViewHolder>() {

    ...

    interface OnItemClickListener {
        fun onItemClick(imageId: Int)
    }
}

//   3). In your ViewHolder class, set an onClickListener on the image view that will call the onItemClick method of the listener with the ID of the clicked image.

class ImageViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
    private val imageView: ImageView = itemView.findViewById(R.id.image_view)

    fun bind(imageId: Int, listener: OnItemClickListener) {
        imageView.setImageResource(imageId)
        itemView.setOnClickListener {
            listener.onItemClick(imageId)
        }
    }
}

//   4). In your activity, create an instance of the OnItemClickListener interface and pass it to the adapter when you set it up.

class MainActivity : AppCompatActivity(), ImageAdapter.OnItemClickListener {
    ...

    override fun onCreate(savedInstanceState: Bundle?) {
        ...

        val adapter = ImageAdapter(images, this)
        recyclerView.adapter = adapter
    }

    override fun onItemClick(imageId: Int) {
        // Handle the click event with the ID of the clicked image
    }
}
