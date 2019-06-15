# The Movies

Simple app witch provide a list of movies from [The Movie DB](https://www.themoviedb.org) API and a short
details with cover image and background. Also this project follow the  MVVM architecture.

If you want to know more about this API follow  [The Movie API](https://www.themoviedb.org/documentation/api)

## Features

- List  of movies
- Search movies
- Movie details (name, image, runtime, budget, relesead date, revenue, details)
- Add movie to Must Watch list
- Add movie to Watched list
- In App Purchase

## Other implementations

- UI improvements using `UIDynamics` to animate cover image. 
- Minor ajustments in UI.
- About screen with some info about this project.
- Code improvements in API class, I created another layer to manage API URL based in [Alaeddine' Medium](https://medium.com/@AladinWay/write-a-networking-layer-in-swift-4-using-alamofire-and-codable-part-1-api-router-349699a47569).
- Changes in the Data Access layer and how it is managed.
- Implemented the `Codable` protocol in models.

## Code coverage

More than 84% with UI test included.

## Build

To build you will need to install [Pods](https://cocoapods.org) and call pod update in your terminal.
```
pod update
```

## Pods used in this app

```
pod 'Alamofire', '~> 4.4'
pod 'AlamofireImage'
pod 'OHHTTPStubs/Swift', '~> 6.0.0'
```

## Layout

I also uploaded in this repository a [Sketch](https://www.sketchapp.com) file with the initial idea about the app layout.

## Contributors

[Phelippe](https://github.com/phyll88) with your amazing knowledge with size class and constraints.


