# WowTokenTidbyt
Display the WoW (World of Warcraft) in-game token price on your Tidbyt!

This WowToken.star starlark script will call the Blizzard Battle.Net API to generate an access token, retrieve the in-game token price, and generate a webp file for Tidbyt to render.

## Requirements

You'll need to visit the [Blizzard's Developer Portal](https://develop.battle.net/documentation/guides) website to create your own client for their APIs. 
Follow their documentation on creating your Client Id and Client Secret that is needed as part of this script. 

## Usage

If you want the token price for a different region, update your region here

```python
def main():                        
    region = "us"        
```

Set your Client Credentials from Blizzard's Battle.Net API inside of the following method found in the wowToken.star script

```python
def SetClientCreds():
    clientId = "YOUR_CLIENT_ID_HERE"
    clientSecret = "YOUR_CLIENT_SECRET_HERE"
    return { "clientId": clientId, "clientSecret": clientSecret }
```
You can view the star output by using

```shell
/fullPathToPixlet/pixlet serve ~/pathToStarScript/wowToken.star
```

## Pushing to your own Tidbyt device

Install pixlet using the [Tidbyt Pixlet Installation](https://tidbyt.dev/docs/build/installing-pixlet) guide
Modify the pixletPush.sh script setting the path to your pixlet installation directory for each command
Modify the render location to where you placed the wowToken.star file
Ensure your pixlet render output is set in the pixlet push command

```shell
/fullPathToPixlet/pixlet render ~/pathToStarScript/wowToken.star
# -i Tidbyt Application Name
# -t Tidbyt Api Token
/fullPathToPixlet/pixlet push YOUR_DEVICE_ID ~/pathOfPixletRenderOutput/wowToken.webp -i WowToken -t YOUR_API_TOKEN_FOR_TIDBYT
```

Use your preferred method to schedule a task to execute the pixletPush.sh script every ~15 minutes

### Crontab Example:
```crontab
*/15 * * * * FullPath/To/pixletPush.sh
```

## Helpful Links
[Build for Tidbyt](https://tidbyt.dev/docs/build/build-for-tidbyt)

[Tidbyt Pixlet Installation](https://tidbyt.dev/docs/build/installing-pixlet)

[Tidbyt Pushing Apps](https://tidbyt.dev/docs/integrate/pushing-apps)

[Blizzard's Developer Portal](https://develop.battle.net/documentation/guides)