import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_feed_posts_usecase.dart';
import '../../domain/usecases/like_post_usecase.dart';
import '../../domain/usecases/add_comment_usecase.dart';

class FeedBloc extends Cubit<void> {
  final GetFeedPostsUseCase getFeedPostsUseCase;
  final LikePostUseCase likePostUseCase;
  final AddCommentUseCase addCommentUseCase;

  FeedBloc({
    required this.getFeedPostsUseCase,
    required this.likePostUseCase,
    required this.addCommentUseCase,
  }) : super(null);
}
