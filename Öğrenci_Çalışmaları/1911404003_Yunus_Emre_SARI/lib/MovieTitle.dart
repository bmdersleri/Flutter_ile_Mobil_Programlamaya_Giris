class MovieTitle{

  String titleId;//MoviesDatabase Endpoint = Title
  String movieName;//MoviesDatabase Endpoint = Title
  String releaseYear;//MoviesDatabase Endpoint = Title
  String type;//MoviesDatabase  Endpoint = Title
  String? description ="";//MDBList Endpoint = Get by IMDb ID
  String? imdbRating = "";//MDBList Endpoint = Get by IMDb ID
  String? genre = "";//Filtreye göre şimdilik



  MovieTitle({this.genre,this.imdbRating,this.description,required this.titleId,required this.type,required this.movieName,required this.releaseYear});




}