import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:video2/constants.dart';
import 'package:video2/core/functions.dart';
import 'package:video2/data/model/response/response_image_model.dart';
import 'package:video2/data/model/response/response_news_model.dart';
import 'package:video2/data/model/response/response_search_model.dart';
import 'package:video2/data/remote/dio_helper.dart';
import 'package:video2/data/remote/dio_helper_news.dart';
import 'package:video2/data/remote/dio_helper_search.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

  List<ResponseNewsModel> newsData = [];

  Future<void> getNewsData() async {
    newsData = [];
    emit(LoadingSearchState());
    await DioHelperNews.getData(
      url: "/v2/top-headlines/",
      query: {
        "country": getCurrentLanguageForNews(),
        "category": "general",
        "apiKey": "aa0cd81a8c784cb5b97239c9af454ff5",
      },
    ).then((value) {
      emit(SuccessSearchState());
      value.data['articles'].forEach((e) {
        newsData.add(ResponseNewsModel.fromJson(e));
        print(e["title"]);
      });
    }).catchError((error) {
      emit(ErrorSearchState());
      print(error.toString());
    });
  }

  List<ResponseSearchModel> searchData = [];
  Future<void> search(String text) async {
    emit(LoadingSearchBarState());
    searchData = [];
    emit(LoadingSearchBarState());
    DioHelperSearch.postData(
      url: "images/",
      query: {
        "Content-Type": "application/json",
        "X-API-KEY": Constants.apiTokenSearch,
      },
      body: {
        "q": text,
        "hl": getCurrentLanguageForNews(),
        "autocorrect": true,
        "page": 50,
        "type": "images"
      },
    ).then((value) {
      emit(SuccessSearchBarState());
      value.data['images'].forEach((e) {
        searchData.add(ResponseSearchModel.fromJson(e));
      });
      print(value.data);
    }).catchError((error) {
      emit(ErrorSearchBarState());
      print(error);
    });
  }
}
