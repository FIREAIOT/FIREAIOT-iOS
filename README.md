# FIREAIOT::iOS

## Env

In order to run this app from source you have to create new file in the project called `Env.swift`, then include the below code and add your google maps api key.

```swift

import Foundation

struct Env {
    static let googleApiKey = "your_api_key"
}

``` 