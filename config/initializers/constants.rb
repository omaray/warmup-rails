SUCCESS = 1
ERR_BAD_CREDENTIALS = -1
ERR_USER_EXISTS = -2
ERR_BAD_USERNAME = -3
ERR_BAD_PASSWORD = -4
MAX_USERNAME_LENGTH = 128
MAX_PASSWORD_LENGTH = 128

ERROR_TO_STRING = 
{
	ERR_BAD_CREDENTIALS => "You entered bad credentials it seems", 
	ERR_USER_EXISTS => "Unfortunately the user already exists! Try another username", 
	ERR_BAD_USERNAME => "The username you entered is in a bad format", 
	ERR_BAD_PASSWORD => "The password you entered is in a bad format"
}