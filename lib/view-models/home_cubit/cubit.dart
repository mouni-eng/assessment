import 'package:mohamed_mounir_assesment/models/repositry_model.dart';
import 'package:mohamed_mounir_assesment/services/repositry_service.dart';
import 'package:mohamed_mounir_assesment/view-models/home_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeStates());

  static HomeCubit get(context) => BlocProvider.of(context);

  final RepositryService _repositryService = RepositryService();
  List<GithubRepository> repositries = [];
  List<GithubRepository> searchedRepositries = [];

  getRepositries() {
    emit(GetRepositriesLoading());
    _repositryService.getAllRepositries().then((value) {
      if (value.isNotEmpty) {
        repositries.addAll(value);
        emit(GetRepositriesSuccess());
      } else {
        emit(GetRepositriesFull());
      }
    }).catchError((error) {
      emit(GetRepositriesError(error: error.toString()));
    });
  }

  searchRepositry({required String query}) {
    emit(GetSearchRepositriesLoading());
    _repositryService.searchRepositries(query: query).then((value) {
      if (value.isNotEmpty) {
        searchedRepositries.addAll(value);
        emit(GetSearchRepositriesSuccess());
      } else {
        emit(GetSearchRepositriesFull());
      }
    }).catchError((error) {
      emit(GetSearchRepositriesError(error: error.toString()));
    });
  }

  clearSearch() {
    _repositryService.clearSearch();
    searchedRepositries.clear();
  }
}
