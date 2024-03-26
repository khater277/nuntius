part of 'stories_cubit.dart';

@freezed
class StoriesState with _$StoriesState {
  const factory StoriesState.initial() = _Initial;

  const factory StoriesState.initStoriesScreenLoading() =
      _InitStoriesScreenLoading;
  const factory StoriesState.testLoading() = _TestLoading;
  const factory StoriesState.testSuccess(
    List<StoryModel> myStories,
    List<ContactStoryModel> contactStories,
    String? errorMsg,
  ) = _TestSuccess;
  const factory StoriesState.testError(String errorMsg) = _TestError;
  const factory StoriesState.initStoriesScreen() = _InitStoriesScreen;
  const factory StoriesState.initAddTextStory() = _InitAddTextStory;
  const factory StoriesState.disposeAddTextStory() = _DisposeAddTextStory;
  const factory StoriesState.pickStoryMediaLoading(MessageType type) =
      _PickStoryMediaLoading;
  const factory StoriesState.pickStoryMedia() = _PickStoryMedia;
  const factory StoriesState.pickStoryMediaError() = _PickStoryMediaError;
  const factory StoriesState.setVideoDuration() = _SetVideoDuration;
  const factory StoriesState.sendStoryLoading() = _SendStoryLoading;
  const factory StoriesState.sendStory() = _SendStory;
  const factory StoriesState.sendStoryError(String errorMsg) = _SendStoryError;
  const factory StoriesState.getFilePercentage(double filePercentage) =
      _GetFilePercentage;
  const factory StoriesState.setImageDimensions() = _SetImageDimensions;
  const factory StoriesState.getMyStoriesLoading() = _GetMyStoriesLoading;
  const factory StoriesState.getMyStories(List<StoryModel> myStories) =
      _GetMyStories;
  const factory StoriesState.getMyStoriesError(String errorMsg) =
      _GetMyStoriesError;
  const factory StoriesState.getContactsStoriesLoading() =
      _GetContactsStoriesLoading;
  const factory StoriesState.getContactsStories(
      List<ContactStoryModel> contactsStories) = _GetContactsStories;
  const factory StoriesState.getContactsStoriesError(String errorMsg) =
      _GetContactsStoriesError;
  const factory StoriesState.getContactsLastStoriesLoading() =
      _GetContactsLastStoriesLoading;
  const factory StoriesState.getContactsLastStories() = _GetContactsLastStories;
  const factory StoriesState.getContactsLastStoriesError(String errorMsg) =
      _GetContactsLastStoriesError;
  const factory StoriesState.openContactStory() = _OpenContactStory;
  const factory StoriesState.getContactsCurrentStoriesLoading() =
      _GetContactsCurrentStoriesLoading;
  const factory StoriesState.getContactsCurrentStories() =
      _GetContactsCurrentStories;
  const factory StoriesState.initStoryView() = _InitStoryView;
  const factory StoriesState.disposeStoryView() = _DisposeStoryView;
  const factory StoriesState.changeStoryIndexLoading() =
      _ChangeStoryIndexLoading;
  const factory StoriesState.changeStoryIndex(int index) = _ChangeStoryIndex;
  const factory StoriesState.resetStoryIndex() = _ResetStoryIndex;
  const factory StoriesState.deleteStoryLoading(String storyId) =
      _DeleteStoryLoading;
  const factory StoriesState.deleteStory() = _DeleteStory;
  const factory StoriesState.deleteStoryError(String errorMsg) =
      _DeleteStoryError;
  const factory StoriesState.contactsStoriesChangedLoading() =
      _ContactsStoriesChangedLoading;
  const factory StoriesState.contactsStoriesChanged() = _ContactsStoriesChanged;
  const factory StoriesState.initReplyToStory() = _InitReplyToStory;
  const factory StoriesState.viewContactStoryLoading() =
      _viewContactStoryLoading;
  const factory StoriesState.viewContactStory() = _viewContactStory;
  const factory StoriesState.replyToStoryLoading() = _ReplyToStoryLoading;
  const factory StoriesState.replyToStory() = _ReplyToStory;
  const factory StoriesState.replyToStoryError(String errorMsg) =
      _ReplyToStoryError;

  const factory StoriesState.createVideosThumbnailsLoading() =
      _CreateVideosThumbnailsLoading;
  const factory StoriesState.createVideosThumbnails() = _CreateVideosThumbnails;
  const factory StoriesState.showRefreshButton() = _ShowRefreshButton;
}
