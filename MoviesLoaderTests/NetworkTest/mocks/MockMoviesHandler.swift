//
//  MockMoviesHandler.swift
//  MoviesLoaderTests
//
//  Created by Ghadeer El-Mahdy on 6/8/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
import SwiftyJSON
@testable import MoviesLoader
class MockMoviesHandler{
    

    var shouldReturnError : Bool
    init(shouldReturnError : Bool){
        self.shouldReturnError = shouldReturnError
    }
    let mockMoviesJSONResponse : [String : Any] =  [
        "page": 1,
        "total_results": 12,
        "total_pages": 3,
        "results": [
            [
                "popularity" : 4.073,
                "vote_count" : 0,
                "video" : false,
                "poster_path" : "/krOMOEjDpw3Mf2EuJb9OgmqD6ft.jpg",
                "id" : 393209,
                "adult" : false,
                "backdrop_path" : nil,
                "original_language" : "en",
                "original_title" : "Avatar 5",
                "genre_ids": [
                    28,
                    12,
                    14,
                    878
                ],
                "title": "Avatar 5",
                "vote_average": 0,
                "overview": "Plot unknown.",
                "release_date": "2027-12-16"
            ],
            [
                "popularity": 5.194,
                "vote_count": 0,
                "video": false,
                "poster_path": "/krOMOEjDpw3Mf2EuJb9OgmqD6ft.jpg",
                "id": 216527,
                "adult": false,
                "backdrop_path": nil,
                "original_language": "en",
                "original_title": "Avatar 4",
                "genre_ids": [
                    28,
                    12,
                    14,
                    878
                ],
                "title": "Avatar 4",
                "vote_average": 0,
                "overview": "",
                "release_date": "2025-12-18"
            ],
            [
                "popularity": 0.639,
                "id": 531229,
                "video": false,
                "vote_count": 1,
                "vote_average": 0,
                "title": "Son Göktürk",
                "release_date": "2025-01-01",
                "original_language": "tr",
                "original_title": "Son Göktürk",
                "genre_ids": [],
                "backdrop_path": "/yZfia37VeZqqoxzq5gKgkTKWbRc.jpg",
                "adult": false,
                "overview": "",
                "poster_path": "/iuk8tKnme2qjFB0wHTaCqJbGuhf.jpg"
            ],
            [
                "popularity": 3.924,
                "vote_count": 6,
                "video": false,
                "poster_path": "/how9ENsi7XCYvF6ncaXmIAoNXn5.jpg",
                "id": 422642,
                "adult": false,
                "backdrop_path": nil,
                "original_language": "en",
                "original_title": "Fantastic Beasts 5",
                "genre_ids": [
                    12,
                    14,
                    10751
                ],
                "title": "Fantastic Beasts 5",
                "vote_average": 0,
                "overview": "The fifth installment of the 'Fantastic Beasts and Where to Find Them' series which follows the adventures of Newt Scamander.",
                "release_date": "2024-12-31"
            ]
        ]
    ]
enum ResponseWithError : Error{
    case responseError
}

}

extension MockMoviesHandler {
    
    func loadDataFromURL( completionHandler: @escaping ([Movie]?, Error?) -> Void) {
        
        if shouldReturnError{
            completionHandler(nil,ResponseWithError.responseError)
        }else{
            
            var moviesArray = [Movie]()
            let movies = mockMoviesJSONResponse["results"] as! [[String:Any]]
            for movie in movies {
                let id = movie["id"]
                let popuarity = movie["popularity"]
                let language = movie["original_language"]
                let release_date = movie["release_date"]
                let title = movie["title"]
                let overView = movie["overview"]
                let poster_path = movie["poster_path"]
                let voteCount = movie["vote_count"]
                let movieObject  = Movie.init(popularity: popuarity as? Double, voteCount: voteCount as? Int, posterPath: poster_path as? String, id: id as? Int, originalLanguage: language as? String, title: title as? String, overview: overView as? String, releaseDate: release_date as? String)
                moviesArray.append(movieObject)
                
            }
            completionHandler(moviesArray,nil)
        }
        
    }
    
    
}

