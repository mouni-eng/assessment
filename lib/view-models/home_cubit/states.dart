class HomeStates {}

class GetRepositriesLoading extends HomeStates {}

class GetRepositriesSuccess extends HomeStates {}

class GetRepositriesError extends HomeStates {
  String? error;
  GetRepositriesError({required this.error});
}

class GetRepositriesFull extends HomeStates {}

class GetSearchRepositriesLoading extends HomeStates {}

class GetSearchRepositriesSuccess extends HomeStates {}

class GetSearchRepositriesError extends HomeStates {
  String? error;
  GetSearchRepositriesError({required this.error});
}

class GetSearchRepositriesFull extends HomeStates {}
