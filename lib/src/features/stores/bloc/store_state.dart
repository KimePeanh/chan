import 'package:equatable/equatable.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class Initializing extends StoreState {}

class FetchingStore extends StoreState {}

class FetchedStore extends StoreState {}

class ErrorFetchingStore extends StoreState {
  final String error;
  ErrorFetchingStore({required this.error});
  @override
  String toString() => 'LoadingFavourite';
}

// class AnnouncementEmpty extends AnnouncementState {}

// class AnnouncementLoading extends AnnouncementState {
//   @override
//   // ignore: prefer_const_constructors_in_immutables
//   AnnouncementLoading({this.isInitiallyLoading = true});
//   final bool isInitiallyLoading;
// }

// class AnnouncementError extends AnnouncementState {}

// class AnnouncementLoaded extends AnnouncementState {
//   // const AnnouncementLoaded({this.announcementList});

//   // final List<Announcement> announcementList;

//   // AnnouncementLoaded copyWith({List<Announcement> posts}) {
//   //   return AnnouncementLoaded(announcementList: posts ?? announcementList);
//   // }

//   // @override
//   // List<Object> get props => [announcementList];

//   // @override
//   // String toString() => 'PostLoaded { posts: ${announcementList.length} }';
// }
