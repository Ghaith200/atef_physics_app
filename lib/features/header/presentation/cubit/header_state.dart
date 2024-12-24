part of 'header_cubit.dart';

@freezed
class HeaderState with _$HeaderState {
  const factory HeaderState.initial() = _Initial;
  const factory HeaderState.load() = headerLoading;
  const factory HeaderState.successAll(List<HeaderModel> models) = AllHeader;
  const factory HeaderState.add(HeaderModel model) = AddHeader;
  // const factory HeaderState.update(HeaderModel model) = UpdateHeader;
  const factory HeaderState.remove(HeaderModel model) = RemoveHeader;
  const factory HeaderState.error(ApiErrorHandler error) = HeaderError;
}
