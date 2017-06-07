# FakeTwitter
Demo App to display my knowledge of iOS

TO LAUNCH APP: Since Githbu has a max file size, I wasn't able to include the Realm.framework in the repo. You may need to link the project with the static library Realm.framework available here : https://static.realm.io/downloads/objc/realm-objc-2.8.0.zip grab the Realm.framework file under ios/static and drag it into the project copy the files in. The app should then compile without any issues. 


-The username and password to log into the app are: U: admin P: admin
-Swiping down on any screen where the keyboard is active dismisses the keyboard.


TODO:
-The Sign Up button currently does not do anything. Eventually want to make it so that you can create an account
and log in using that account to test the app.

-Profile page: Currently not implemented, want it to eventually show just a list of tweets you have posted along with your 
username, handle and profile picture.

-Still need to decide on a way to store the User data for a currently logged in user: Ie his account name and handle.

-Tests: -Should create some unit tests for verifying that data is being stored and retrieved from the local Realm db

        -Should create automated UI tests to go through and test different features like logging in and posting tweets.
