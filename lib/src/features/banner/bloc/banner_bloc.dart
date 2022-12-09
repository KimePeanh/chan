import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/banner/models/banner.dart';
import 'package:lady_skin/src/features/banner/repositories/banner_repository.dart';
import 'banner_event.dart';
import 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  List<Banner> banners = [];
  BannerRepository _appContentsRepository = BannerRepository();
  @override
  BannerBloc() : super(FetchingBanner());

  @override
  Stream<BannerState> mapEventToState(BannerEvent event) async* {
    if (event is FetchStarted) {
      yield FetchingBanner();
      try {
        await Future.delayed(Duration(milliseconds: 200));
        banners = await _appContentsRepository.getBannerImages();

        yield FetchedBanner();
      } catch (e) {
        yield ErrorFetchingBanner(error: "Unknown error acccured!");
      }
    }
  }
}
