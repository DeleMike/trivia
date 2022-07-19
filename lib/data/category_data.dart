import '../models/category.dart';
import '../configs/constants.dart';

///store for all quiz categories with their required data
const List<Category> categories = [
  Category('Any Category', 0, AssetsImages.anyImg),
  Category('General Knowledge', 9, AssetsImages.generalImg),
  Category('Entertainment: Books', 10, AssetsImages.booksImg),
  Category('Entertainment: Film', 11, AssetsImages.filmImg),
  Category('Entertainment: Music', 12, AssetsImages.musicImg),
  Category('Entertainment: Musicals & Theaters', 13, AssetsImages.theaterImg),
  Category('Entertainment: Television', 14, AssetsImages.televisionImg),
  Category('Entertainment: Video Games', 15, AssetsImages.videoGameImg),
  Category('Entertainment: Board Games', 16, AssetsImages.boardGameImg),
  Category('Science & Nature', 17, AssetsImages.natureImg),
  Category('Science: Computers', 18, AssetsImages.computersImg),
  Category('Science: Mathematics', 19, AssetsImages.mathImg),
  Category('Mythology', 20, AssetsImages.mythImg),
  Category('Sport', 21, AssetsImages.sportsImg),
  Category('Geography', 22, AssetsImages.geoImg),
  Category('History', 23, AssetsImages.historyImg),
  Category('Politics', 24, AssetsImages.politicsImg),
  Category('Art', 25, AssetsImages.artImg),
  Category('Celebrities', 26, AssetsImages.celebritiesImg),
  Category('Animals', 27, AssetsImages.animalsImg),
  Category('Vehicles', 28, AssetsImages.vehiclesImg),
  Category('Entertainment: Comics', 29, AssetsImages.comicImg),
  Category('Science: Gadgets', 30, AssetsImages.gadgetsImg),
  Category('Entertainment: Japanese Anime & Manga', 31, AssetsImages.animeImg),
  Category('Entertainment: Cartoon & Animations', 32, AssetsImages.cartoonImg),
];
