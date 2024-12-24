import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/features/header/header_api_services/header_api_services.dart';
import 'package:atef_physics/features/header/model/header_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'header_state.dart';
part 'header_cubit.freezed.dart';

class HeaderCubit extends Cubit<HeaderState> {
  HeaderCubit() : super(const HeaderState.initial());

  final HeaderApiServices apiServices = HeaderApiServices();
  final loading = const HeaderState.load();

  /// Fetch all headers
  Future<void> getHeaders() async {
    emit(loading);
    final data = await apiServices.getHeaders();
    data.when(
      success: (headers) => emit(HeaderState.successAll(headers)),
      failure: (error) => emit(HeaderState.error(error)),
    );
  }

  /// Add a new header
  Future<void> addHeader({
    required String path,
    required bool isVideo,
  }) async {
    emit(loading);
    final data = await apiServices.addHeader(path, isVideo);
    data.when(
      success: (_) async {
        // Refetch headers after addition
        await getHeaders();
      },
      failure: (error) => emit(HeaderState.error(error)),
    );
  }

  /// Remove a header
  Future<void> removeHeader({required HeaderModel model}) async {
    emit(loading);
    final data = await apiServices.removeHeader(model);
    data.when(
      success: (_) async {
        // Refetch headers after deletion
        await getHeaders();
      },
      failure: (error) => emit(HeaderState.error(error)),
    );
  }
}
