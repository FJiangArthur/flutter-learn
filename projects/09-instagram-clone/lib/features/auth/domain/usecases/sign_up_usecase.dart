import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase implements UseCase<UserEntity, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await repository.signUp(
      email: params.email,
      password: params.password,
      username: params.username,
      fullName: params.fullName,
    );
  }
}

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String username;
  final String fullName;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.username,
    required this.fullName,
  });

  @override
  List<Object?> get props => [email, password, username, fullName];
}
