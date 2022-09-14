abstract class UploadStates{}
class InitialState extends UploadStates{}

class LoadingUploadState extends UploadStates{}
class ValidUploadState extends UploadStates{}
class FailUploadState extends UploadStates{}

class LoadingSelectState extends UploadStates{}
class ValidSelectState extends UploadStates{}
class FailSelectState extends UploadStates{}

class LoadingUploadLecState extends UploadStates{}
class ValidUploadLecState extends UploadStates{}
class FailUploadLecState extends UploadStates{}

class ValidRemoveState extends UploadStates{}
class FailRemoveState extends UploadStates{}