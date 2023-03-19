# Movies Clone Swift Project

Developed an ios application to keep track of the latest movies and Television shows, utilizing UIKit and the Model-View-ViewModel (MVVM) design pattern. This project was also connected to the YouTube API for browsing and downloading movie trailers, which were saved locally in the Core Data database. Additionally, the SDWebImage library was used, which provided an asynchronous image downloading tool from the internet
---
## MVVM Design Pattern

Using Model View View-Model Design Pattern to helps to cleanly separate the business and presentation logic of the application, and to address numerous development issues and can make an application easier to test, maintain, and evolve.

[(https://user-images.githubusercontent.com/95555310/226164697-55922cfc-078d-4d3b-8bd6-8b413081e0d0.png)](https://user-images.githubusercontent.com/95555310/226164040-d0f9a8fc-bc54-41fb-b02c-68335c54d1b1.mov) 

---
## The Movie Database (TMDB) API

Implementing a connection to TMDB API to GET the latest movies and tv shows, without using networking SDKs.
Initialize API file contains only the API link and API Key:
```

class API {
    static let mainLink = "https://api.themoviedb.org"
    static let apiKey = "19688aff36e2fef518cab9addc2ffe29"
    }

```
Decoding JSON Directly from URL data
```
import Foundation

enum APIError: Error {
    case failedToGetData
}

class APIConnector: API {
    
    static let shared = APIConnector()
    
    func getTrendingMovies (completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(APIConnector.mainLink)/3/trending/movie/day?api_key=\(APIConnector.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitlesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
                
        }
        task.resume()
    }
    ```
