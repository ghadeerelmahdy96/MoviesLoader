//
//  CoreDataHandler.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/6/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHandler{
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private  var managedContext:NSManagedObjectContext
    private let entity : NSEntityDescription
    static var sharedInstance = CoreDataHandler()
    
    private init () {
        managedContext = appDelegate.persistentContainer.viewContext
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        entity =
            NSEntityDescription.entity(forEntityName: "MovieEntity",
                                       in: managedContext)!
    }
    //MARK:- Save Entities
    func save ( movies: [Movie],completion: @escaping (Result<Bool, LocalDataResponseError>) -> Void ) {
        var isSaved = false
        for movie in movies {
            let movieObject = NSManagedObject(entity: entity,
                                              insertInto: managedContext)
            prepareMovieToNSManagedObject(movie: movie, movieObject: movieObject)
        }
        do {
            try managedContext.save()
            isSaved = true
            completion(Result.success(isSaved))
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(Result.failure(LocalDataResponseError.saving))
        }
       // return isSaved
    }
    private func prepareMovieToNSManagedObject(movie:Movie,  movieObject : NSManagedObject){
        movieObject.setValue(movie.title, forKeyPath: "title")
        movieObject.setValue(movie.releaseDate, forKey: "release_date")
        movieObject.setValue(movie.overview, forKey: "overview")
        movieObject.setValue(movie.voteAverage, forKey: "vote_average")
        movieObject.setValue(movie.id, forKey: "id")
        movieObject.setValue(movie.posterPath, forKey: "poster_path")
        //movieObject.setValue(movie.genreIDS, forKey: "genre_ids")
        movieObject.setValue(movie.popularity, forKey: "popularity")
        movieObject.setValue(movie.originalLanguage, forKey: "language")
    }
    //MARK:- Fetch entities
    func fetchData(fetchLimit: Int,fetchOffeset :Int ,completion: @escaping (Result<[Movie], LocalDataResponseError>) -> Void) {
        
        var movies = [Movie]()
        var moviesNSManagedObjects = Array<NSManagedObject>()
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        fetchRequest.fetchLimit = fetchLimit
        fetchRequest.fetchOffset = fetchOffeset
        do {
            moviesNSManagedObjects = try managedContext.fetch(fetchRequest)
            moviesNSManagedObjects.forEach { (object) in
                let movie = prepareNSManagedObjectToMovie(movieManagedObject: object)
                movies.append(movie)
            }
            completion(Result.success(movies))
        } catch{
            print("error in fetchData")
            completion(Result.failure(LocalDataResponseError.fetching))
        }
    }
    
    private func prepareNSManagedObjectToMovie (movieManagedObject : NSManagedObject) -> Movie  {
        var movie = Movie()
        movie.title = movieManagedObject.value(forKey: "title") as? String
        movie.releaseDate = movieManagedObject.value( forKey: "release_date") as? String
        movie.overview = movieManagedObject.value( forKey: "overview") as? String
        movie.voteAverage = movieManagedObject.value(forKey: "vote_average") as? Double
        movie.id = movieManagedObject.value(forKey: "id") as? Int
        movie.posterPath =  movieManagedObject.value(forKey: "poster_path") as? String
        // movieManagedObject.value( forKey: "genre_ids")
        movie.popularity = movieManagedObject.value( forKey: "popularity") as? Double
        movie.originalLanguage =  movieManagedObject.value( forKey: "language") as? String
        return movie
    }
    //MARK:- Getting count records in Entity "MovieEntity"
    func getMoviesCount(completion: @escaping (Result<Int, LocalDataResponseError>) -> Void) {
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
           do {
               let count = try managedContext.count(for: fetchRequest)
             completion(Result.success(count))
           } catch {
            completion(Result.failure(LocalDataResponseError.fetching))
           }
       }
    
}
