abstract class RegisterStates {}
class InitialState extends RegisterStates{}
class ChangePasswordVisibilityState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}
class RegisterValidState extends RegisterStates{}
class RegisterFailState extends RegisterStates{}

class CreateUserLoadingState extends RegisterStates{}
class CreateUserValidState extends RegisterStates{}
class CreateUserFailState extends RegisterStates{}


