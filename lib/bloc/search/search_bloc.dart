import 'package:bloc/bloc.dart';
import '../../infrastructure/functions/db_functions.dart';
import '../../infrastructure/models/studentModel.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial(student: studenList)) {
    on<OnSearch>((event, emit) {
      emit(
        SearchState(
          student: event.searchDetail
              .where((element) => element.name
                  .toLowerCase()
                  .contains(event.value.toLowerCase()))
              .toList(),
        ),
      );
    });
  }
}
