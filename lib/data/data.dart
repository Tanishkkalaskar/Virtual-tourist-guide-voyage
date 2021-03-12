class SliderModel {
  String imagePath;
  String title;
  String desc;

  SliderModel({this.imagePath, this.title, this.desc});

  void setImageAssetPath(String getimagePath) {
    imagePath = getimagePath;
  }

  void settitle(String gettitle) {
    title = gettitle;
  }

  void setdesc(String getdesc) {
    desc = getdesc;
  }

  String getImageAssetPath() {
    return imagePath;
  }

  String gettitle() {
    return title;
  }

  String getdesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setImageAssetPath("assets/info.png");
  sliderModel.settitle("Capture");
  sliderModel.setdesc(
      "Capture the image of Monument from camera and get its information");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setImageAssetPath("assets/nearby.png");
  sliderModel.settitle("Nearby Places");
  sliderModel.setdesc("Get notified about by nearby monumentes");

  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setImageAssetPath("assets/review.png");
  sliderModel.settitle("Review");
  sliderModel.setdesc("Get Reviews about nearby destinations.");

  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
