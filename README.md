# WowTokenTidbyt
Display the WoW (World of Warcraft) in-game token price on your Tidbyt!

![Preview](/wowTokenPreview.png)

This [wowToken.star](https://github.com/semutoO/WowTokenTidbyt/blob/master/wowToken.star) starlark script will call the Blizzard Battle.Net API to generate an access token, retrieve the in-game token price, and generate a webp file for Tidbyt to render.

## Requirements

You'll need to visit the [Blizzard's Developer Portal](https://develop.battle.net/documentation/guides) website to create your own client for their APIs. Follow their documentation on creating your Client Id and Client Secret that is needed as part of this script. 

To view the output on your Tidbyt, see the [Pushing to your own Tidbyt device](#pushing-to-your-own-tidbyt-device) section

## Usage

If you want the token price for a different region, update your region in the [main function](https://github.com/semutoO/WowTokenTidbyt/blob/9e7e19011c3b34ce527c265d3666e29d5f5dbaac/wowToken.star#L53) of the wowToken.star script

```python
def main():                        
    region = "us"        
```

Set your client credentials from [Blizzard's Developer Portal](https://develop.battle.net/documentation/guides) inside of the following [SetClientCreds function](https://github.com/semutoO/WowTokenTidbyt/blob/9e7e19011c3b34ce527c265d3666e29d5f5dbaac/wowToken.star#L8)

```python
def SetClientCreds():
    clientId = "YOUR_CLIENT_ID_HERE"
    clientSecret = "YOUR_CLIENT_SECRET_HERE"
    return { "clientId": clientId, "clientSecret": clientSecret }
```
You can preview the starlark output by using the following pixlet cli command

```shell
/fullPathToPixlet/pixlet serve ~/pathToStarScript/wowToken.star
```

## Pushing to your own Tidbyt device

Install pixlet using the [Tidbyt Pixlet Installation](https://tidbyt.dev/docs/build/installing-pixlet) guide

Modify the [pixletPush.sh shell script](https://github.com/semutoO/WowTokenTidbyt/blob/master/pixletPush.sh) setting the path to your pixlet installation directory for each command

Modify the render location to where you placed the wowToken.star file

Ensure your pixlet render webp file output ([wowToken.webp](https://github.com/semutoO/WowTokenTidbyt/blob/master/wowToken.webp)) is set in the pixlet push command

```shell
/fullPathToPixlet/pixlet render ~/pathToStarScript/wowToken.star
# -i Tidbyt Application Name
# -t Tidbyt Api Token
/fullPathToPixlet/pixlet push YOUR_DEVICE_ID ~/pathOfPixletRenderOutput/wowToken.webp -i WowToken -t YOUR_API_TOKEN_FOR_TIDBYT
```

Use your preferred method to schedule a task to execute the pixletPush.sh script every ~15 minutes

#### Crontab Example:
```crontab
*/15 * * * * FullPath/To/pixletPush.sh
```

## Helpful Links
[Build for Tidbyt](https://tidbyt.dev/docs/build/build-for-tidbyt)

[Tidbyt Pixlet Installation](https://tidbyt.dev/docs/build/installing-pixlet)

[Tidbyt Pushing Apps](https://tidbyt.dev/docs/integrate/pushing-apps)

[Blizzard's Developer Portal](https://develop.battle.net/documentation/guides)

## Contributions
Any contributions are welcome! Just submit a pull request with a description of the changes.
