//
//  RepositoryImp.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/5/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
class RepositoryImp: RepositoryProtocol {
    func getMoviesCountInLocalDB(completion: @escaping (Result<Int, LocalDataResponseError>) -> Void) {
        let dataStore = CoreDataHandler.sharedInstance
        dataStore.getMoviesCount(completion: completion)
    }
    
    //MARK:- Local DB
    func getDataFromLocalDB(fetchLimit: Int,fetchOffeset :Int, completion: @escaping (Result<[Movie], LocalDataResponseError>) -> Void) {
        let dataStore = CoreDataHandler.sharedInstance
        dataStore.fetchData( fetchLimit: fetchLimit, fetchOffeset: fetchOffeset, completion: completion)
    }
    
    func postDataToLocalDB(With entities: [Movie], completion: @escaping (Result<Bool, LocalDataResponseError>) -> Void){
        let dataStore = CoreDataHandler.sharedInstance
        dataStore.save(movies: entities, completion: completion)
    }
    //MARK:- Network
    func getDataFromAPI<T>(From url: String,parameters: Parameters ,page : Int,completion: @escaping (Result<T, DataResponseError>) -> Void) where T : Codable{
        doGet(url: url, parameters: parameters, page: page,completion: completion )
    }
    
    func postDataToAPI<T, V>(To url: String, With object: T, completion: @escaping (Result<V, DataResponseError>) -> Void) where T : Codable, V : Codable{
          doPost(url: url, object: object, completion: completion)
    }

}
