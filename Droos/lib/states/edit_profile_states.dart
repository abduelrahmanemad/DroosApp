abstract class EditProfileStates {}

class InitialState extends EditProfileStates{}

class RemoveImageState extends EditProfileStates{}

class RemovePickedImageState extends EditProfileStates{}

class UploadPickedImageValidState extends EditProfileStates{}

class UpdateUserValidState extends EditProfileStates{}
class UpdateUserLoadingState extends EditProfileStates{}
class UpdateUserFailState extends EditProfileStates{}

class ChangePassClickState extends EditProfileStates{}
class ChangePasswordVisibilityState extends EditProfileStates{}

class PickProfilePhotoValid extends EditProfileStates{}
class PickCoverPhotoFail extends EditProfileStates{}

class ChangePasswordValidState extends EditProfileStates{}
class ChangePasswordFailState extends EditProfileStates{}

class ChangeEmailValidState extends EditProfileStates{}
class ChangeEmailFailState extends EditProfileStates{}

class GetUserLoadingState extends EditProfileStates{}
class GetUserValidState extends EditProfileStates{}
class GetUserFailState extends EditProfileStates{}