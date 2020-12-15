class SliderModel {
  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1

  sliderModel.setDesc("For easy acces to healthcare and ambulance.");
  sliderModel.setTitle("Emergency");
  sliderModel.setImageAssetPath("assets/amb.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel
      .setDesc("Find the best doctors in your town, and get treated early.");
  sliderModel.setTitle("Search");
  sliderModel.setImageAssetPath("assets/search.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("Easy appointment online using your mobile phones.");
  sliderModel.setTitle("Appointment");
  sliderModel.setImageAssetPath("assets/appoint.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
