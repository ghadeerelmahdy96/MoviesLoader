//
//  RepositoryImp.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/5/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
class RepositoryImp: RepositoryProtocol {
    func getDataFromLocalDB<T>(batchSize: Int, completion: @escaping (Result<T, DataResponseError>) -> Void) where T : Codable{
        
    }
    
    func postDataToLocalDB<T, V>(With entities: T, completion: @escaping (Result<V, DataResponseError>) -> Void) where T : Codable, V : Codable {
        
    }
    
    func getDataFromAPI<T>(From url: String,parameters: Parameters ,page : Int,completion: @escaping (Result<T, DataResponseError>) -> Void) where T : Codable{
        doGet(url: url, parameters: parameters, page: page,completion: completion )
    }
    
    func postDataToAPI<T, V>(To url: String, With object: T, completion: @escaping (Result<V, DataResponseError>) -> Void) where T : Codable, V : Codable{
          doPost(url: url, object: object, completion: completion)
    }

}
