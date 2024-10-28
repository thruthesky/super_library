# Trouble Shooting


## Database URL setup


If you see error messages like below;

- `Exception: SuperLibrary.databaseURL is null`
- `Error: FIREBASE FATAL ERROR: Cannot parse Firebase url. Please use https://<YOUR FIREBASE>.firebaseio.com`

Then, you may suspect that there is something wrong with the databaseURL in web running mode.




For mobile build and run, the database url setup is automatically done by the flutterflow. You will simply enable the database and then re-configure the firebase config files in FlutterFlow.

