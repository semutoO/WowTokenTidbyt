load("render.star", "render")
load("http.star", "http")
load("time.star", "time")
load("secret.star", "secret")
load("encoding/base64.star", "base64")    
load("humanize.star","humanize")

def SetClientCreds():
    clientId = "YOUR_CLIENT_ID_HERE"
    clientSecret = "YOUR_CLIENT_SECRET_HERE"
    return { "clientId": clientId, "clientSecret": clientSecret }

def GetApiUrl(region):
    apiBaseUrl = "api.blizzard.com"
    return "https://" + region + "." + apiBaseUrl.lstrip(".")    

def GetWowAccessToken(region, clientCredentials):
    #TODO: Cache and check token's expiration date
    url = "https://%s.battle.net/oauth/token" % region    
    body = {"grant_type": 'client_credentials'}
    response = http.post(url, form_body=body, auth=(clientCredentials["clientId"], clientCredentials["clientSecret"]))

    if(response.status_code != 200):
        print(response)            
        fail("An error occurred retrieving the access token")            
    else:
        response = response.json()
        return response["access_token"]
                        
def GetTokenPriceRequest(region):
    namespace = "dynamic-%s" % region
    locale = "en_%s" % region
    return { "region" : region, "namespace" : namespace, "locale" : locale }

def GetWowTokenPrice(apiUrl, tokenRequest, accessToken):  
    params = dict()
    params["region"] = tokenRequest["region"]
    params["namespace"] = tokenRequest["namespace"]
    params["locale"] = tokenRequest["locale"]
    tokenResponse = http.get(apiUrl + "/data/wow/token/index", params=params, headers={"Authorization": "Bearer %s" % accessToken})        
    
    if(tokenResponse.status_code != 200):
        return 0
    
    return tokenResponse.json()["price"]                                   

def GetWowTokenImage():    
    #TODO: Cache the image
    wowTokenImage = http.get("https://static.wikia.nocookie.net/wowpedia/images/a/ab/WoW_Token_art.jpg/revision/latest?cb=20180914192153").body()
    return wowTokenImage

def main():                        
    region = "us"        
    apiUrl = GetApiUrl(region)            
    clientCredentials = SetClientCreds()
    accessToken = GetWowAccessToken(region, clientCredentials)        
    tokenPriceRequest = GetTokenPriceRequest(region)
    tokenPrice = GetWowTokenPrice(apiUrl, tokenPriceRequest, accessToken)

    tokenDenominationDividers = { "copper" : 1, "silver": 100, "gold": 10000 }
    tokenPriceDisplay = tokenPrice / tokenDenominationDividers["gold"]    
    wowTokenImage = GetWowTokenImage()

    return render.Root( 
       child = render.Box(
           render.Row(
               expanded = True,
               main_align = "space_evenly",
               cross_align = "center",
               children = [
                   render.Image(src = wowTokenImage, width=25, height=30),                   
                   render.Text(humanize.comma(tokenPriceDisplay), color="#ffd700")                    
               ],
           )
       )
    )