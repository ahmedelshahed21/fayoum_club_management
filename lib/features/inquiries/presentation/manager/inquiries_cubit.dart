import 'package:fayoum_club_management/features/inquiries/data/repos/inquiries_repo/inquiries_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'inquiries_state.dart';
import '../../data/models/inquiries_model.dart';

class InquiriesCubit extends Cubit<InquiriesState> {
  final InquiriesRepo inquiriesRepo;

  InquiriesCubit(this.inquiriesRepo) : super(InquiriesInitial());

  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoading = false;
  final List<InquiryItem> _items = [];

  Future<void> fetchInquiries({bool refresh = false}) async {
    if (_isLoading) return;

    // لو Refresh: رجع للصفحة الأولى وفرّغ البيانات القديمة
    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
      _items.clear();
    }

    if (!_hasMore) return;

    _isLoading = true;
    if (_currentPage == 1) emit(InquiriesLoading());

    final result = await inquiriesRepo.getInquiries(page: _currentPage);

    result.fold(
          (failure) {
        emit(InquiriesError(failure.errMessage));
      },
          (data) {
        _items.addAll(data.items);
        _hasMore = _currentPage < data.pagination!.totalPages;

        emit(InquiriesLoaded(
          items: List.from(_items),
          hasMore: _hasMore,
        ));

        _currentPage++;
      },
    );

    _isLoading = false;
  }
}

