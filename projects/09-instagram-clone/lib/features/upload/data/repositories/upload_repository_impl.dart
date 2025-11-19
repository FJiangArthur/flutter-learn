import '../../domain/repositories/upload_repository.dart';
import '../datasources/upload_remote_datasource.dart';

class UploadRepositoryImpl implements UploadRepository {
  final UploadRemoteDataSource remoteDataSource;

  UploadRepositoryImpl({required this.remoteDataSource});
}
