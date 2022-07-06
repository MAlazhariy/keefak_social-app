
String getImageName(String postImage) {
  if(postImage.isEmpty) {
    return '';
  }
  return postImage.substring(
    postImage.indexOf('image_picker'),
    postImage.indexOf('?alt'),
  );
}
