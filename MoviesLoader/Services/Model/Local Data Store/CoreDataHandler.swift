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
        entity =
            NSEntityDescription.entity(forEntityName: "MovieEntity",
                                       in: managedContext)!
    }
    //MARK:- Save Entities
    func save( movies: [Movie])  {
        var isSaved = false
        for movie in movies {
            let movieObject = NSManagedObject(entity: entity,
                                              insertInto: managedContext)
            prepareMovieToNSManagedObject(movie: movie, movieObject: movieObject)
        }
        do {
            try managedContext.save()
            isSaved = true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
       // return isSaved
    }
    private func prepareMovieToNSManagedObject(movie:Movie,  movieObject : NSManagedObject){
        movieObject.setValue(movie.title, forKeyPath: "title")
        movieObject.setValue(movie.releaseDate, forKey: "release_date")
        movieObject.setValue(movie.overview, forKey: "overview")
        movieObject.setValue(movie.voteAverage, forKey: "vote_average")
        movieObject.setValue(movie.id, forKey: "id")
        //movieObject.setValue(movie.genreIDS, forKey: "genre_ids")
        movieObject.setValue(movie.popularity, forKey: "popularity")
        movieObject.setValue(movie.originalLanguage, forKey: "language")
    }
    //MARK:- Fetch entities
    func fetchData(with batchSize : Int) -> [Movie]{
        
        var movies = [Movie]()
        var moviesNSManagedObjects = Array<NSManagedObject>()
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        fetchRequest.fetchBatchSize = batchSize
        do {
            moviesNSManagedObjects = try managedContext.fetch(fetchRequest)
            moviesNSManagedObjects.forEach { (object) in
                let movie = prepareNSManagedObjectToMovie(movieManagedObject: object)
                movies.append(movie)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        catch{
            print("error in fetchData")
        }
        return movies
    }
    
    private func prepareNSManagedObjectToMovie (movieManagedObject : NSManagedObject) -> Movie  {
        var movie = Movie()
        movie.title = movieManagedObject.value(forKey: "title") as? String
        movie.releaseDate = movieManagedObject.value( forKey: "release_date") as? String
        movie.overview = movieManagedObject.value( forKey: "overview") as? String
        movie.voteAverage = movieManagedObject.value(forKey: "vote_average") as? Double
        movie.id = movieManagedObject.value(forKey: "id") as? Int
        // movieManagedObject.value( forKey: "genre_ids")
        movie.popularity = movieManagedObject.value( forKey: "popularity") as? Double
        movie.originalLanguage =  movieManagedObject.value( forKey: "language") as? String
        return movie
    }
    
}
