# Spotify Discover Weekly Save

## Description
This projects aims to address the problem of not having time in the week to listen to your weekly refresh of songs in Discover Weekly.  This script will fetch all songs each week and save to a new playlist in your Spotify account.  Includes AWS Lambda and EventBridge Setup.  

## Demo

![Screen Recording 2023-11-25 at 4 12 02 PM](https://github.com/techmatlock/spotify-discover-weekly-save/assets/2618095/0a7b4f9a-5e17-4267-9dbe-e505ea7c931c)

## Prerequisites
* Python <= 3.10.12 
* pip <= 22.3.1
* spotipy <= 2.23.0

## Installation

1. Clone this repository to your local machine.
```
git clone https://github.com/techmatlock/spotify-discover-weekly-save-headless.git
```
2. On your local machine in the project directory, initialize your virtual environment. ```python -m venv venv```
3. Install the required packages: ```pip install -r requirements.txt```
4. Go to your Spotify Developer API dashboard - https://developer.spotify.com
5. Create a new app, go to Settings, and save the CLIENT_ID, CLIENT_SECRET, and REDIRECT_URI.
<img width="1660" alt="Screenshot 2023-11-26 at 7 56 12 PM" src="https://github.com/techmatlock/spotify-discover-weekly-save/assets/2618095/48814c11-a676-42f3-a229-f5726c533173">

6. Go to your Spotify account and add a new playlist called "Discover Weekly Exports.
7. You only have to do this ONCE.  If you don't have a ".cache*" file already in your project directory, you must first generate one. (This is a feature missing from Spotify OAuth and must generate token on machine with a browser.)

8. Add this line ```sp_oauth.get_access_token()``` below the code below<br><br>
```sp_oauth = SpotifyOAuth(client_id=SPOTIPY_CLIENT_ID, client_secret=SPOTIPY_CLIENT_SECRET, redirect_uri=SPOTIPY_REDIRECT_URI, username=USERNAME, scope=SCOPE, cache_path=CACHE_PATH)``` 
9. Once you have your .cache-username token in your project directory, you can remove this line of code ```sp_oauth.get_access_token()```
10. In the project directory, execute the following commands to prepare the Lambda function
```
mkdir package
pip3 install --target ./package spotipy
cd ..
cd package
zip -r ../spotipy-package.zip .
cd ..
clear
python3 -m venv venv
source venv/bin/activate
pip3 install spotipy
deactivate
cd venv/lib/python3.12/site-packages
zip -r ../../../../my_deployment_package.zip .
cd ../../../
zip my_deployment_package.zip lambda_function.py
```
11. Upload the my_deployment_package.zip & spotipy-package.zip to AWS Lambda
12. Make sure to set your environment variables in Lambda as seen in the screenshot below.
![Screenshot 2023-12-26 at 1 14 51 PM](https://github.com/techmatlock/spotify-discover-weekly-save-awslambda/assets/2618095/382e0202-724e-46dd-9e55-da9c5da0e2d9)
13. In AWS Lambda, make sure to change the Handler under Runtime Settings to be lambda_function.lambda_handler
![Screenshot 2023-12-26 at 1 19 46 PM](https://github.com/techmatlock/spotify-discover-weekly-save-awslambda/assets/2618095/a0dadeda-a270-439b-b3ae-74eb4115f48f)

## Usage
* In order to benefit from this script, you need to setup crontab (Linux/Mac) or Task Scheduler (Windows) to run the script every week.
* The reason we have to use song URI's instead of song names in the script is because the spotipy library doesn't allow you to pass song names as a parameter to the user_playlist_add_tracks method. 

## Errors
This error means the song's already exist in the exported playlist and can be ignored:
```
HTTP Error for POST to https://api.spotify.com/v1/playlists/7KJ6tM0pCMw6uAifySojjo/tracks with Params: {'position': None} returned 400 due to Error parsing JSON.
An error occurred: http status: 400, code:-1 - https://api.spotify.com/v1/playlists/7KJ6tM0pCMw6uAifySojjo/tracks:
 Error parsing JSON., reason: None
```

## Contributing
Contributions to this project are welcome. Please fork the repository and submit a pull request.

