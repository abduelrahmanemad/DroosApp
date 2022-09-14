abstract class LoginStates {}
class InitialState extends LoginStates{}
class ChangePasswordVisibilityState extends LoginStates{}

class LoginLoadingState extends LoginStates{}
class LoginValidState extends LoginStates{}
class LoginFailState extends LoginStates{}

class GetUserLoadingState extends LoginStates{}
class GetUserValidState extends LoginStates{}
class GetUserFailState extends LoginStates{}