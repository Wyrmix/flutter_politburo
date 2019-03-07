import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sealed_unions/sealed_unions.dart';

class PhotoSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PhotoSwiperBloc extends Bloc<PhotoSwiperEvent, PhotoSwiperState> {
  @override
  PhotoSwiperState get initialState => PhotoSwiperState.empty();

  @override
  Stream<PhotoSwiperState> mapEventToState(PhotoSwiperState currentState,
      PhotoSwiperEvent event) {

  }
}

class PhotoSwiperEvent extends Union3Impl<PhotoSwiperEventLoading, PhotoSwiperEventLoaded, PhotoSwiperEventError> {
  static final _factory = Triplet<PhotoSwiperEventLoading, PhotoSwiperEventLoaded, PhotoSwiperEventError>();

  PhotoSwiperEvent(Union3<PhotoSwiperEventLoading, PhotoSwiperEventLoaded, PhotoSwiperEventError> union): super(union);

  factory PhotoSwiperEvent.loading() => _factory.first(PhotoSwiperEventLoading());
  factory PhotoSwiperEvent.loaded(List<String> photos) => _factory.second(PhotoSwiperEventLoaded(photos));
  factory PhotoSwiperEvent.error(Object error) => _factory.third(PhotoSwiperEventError(error));
}
class PhotoSwiperEventLoading {}
class PhotoSwiperEventLoaded {
  final List<String> photos;
  PhotoSwiperEventLoaded(this.photos);
}
class PhotoSwiperEventError {
  final Object error;
  PhotoSwiperEventError(this.error);
}

class PhotoSwiperState extends Union2Impl<PhotoSwiperStateEmpty, PhotoSwiperStateList> {
  static final _factory = Doublet<PhotoSwiperStateEmpty, PhotoSwiperStateList>();

  PhotoSwiperState(Union2<PhotoSwiperStateEmpty, PhotoSwiperStateList> union): super(union);

  factory PhotoSwiperState.empty() => _factory.first(PhotoSwiperStateEmpty());
  factory PhotoSwiperState.list(List<String> photos) => _factory.second(PhotoSwiperStateList(photos));
}
class PhotoSwiperStateEmpty {}
class PhotoSwiperStateList {
  final List<String> photos;
  PhotoSwiperStateList(this.photos);
}
