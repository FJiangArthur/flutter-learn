import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/upload_post_usecase.dart';

class UploadBloc extends Cubit<void> {
  final UploadPostUseCase uploadPostUseCase;

  UploadBloc({required this.uploadPostUseCase}) : super(null);
}
