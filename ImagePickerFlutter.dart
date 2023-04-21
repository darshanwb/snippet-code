Future<void> _showAddItemDialog() async {
    String name = '';
    //String imagePath = '';
    XFile? imageFile;

    final picker = ImagePicker();
    // final picker = ImagePicker();
    // final pickedImage = await picker.getImage(source: ImageSource.gallery);
    // if (pickedImage != null) {
    //   image = File(pickedImage.path);
    // }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (value) {
                name = value;
              },
            ),
            TextButton(
              onPressed: () async {
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  imageFile = pickedFile;
                });
              },
              child: const Text('Choose Image'),
            ),
            if (imageFile != null) Image.file(File(imageFile!.path)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Add the new item to the list
              setState(() {
                // _items.add(Item(name: name, imageFile: imageFile!));
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
