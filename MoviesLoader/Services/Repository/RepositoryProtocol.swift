//
//  RepositoryProtocol.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/5/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
protocol RepositoryProtocol {
    func getDataFromAPI<T:Codable>(From url: String,parameters: Parameters ,page : Int,completion: @escaping (Result<T, DataResponseError>) -> Void )
    func postDataToAPI<T:Codable, V:Codable>(To url: String,With object : T, completion: @escaping (Result<V, DataResponseError>) -> Void)
    func getDataFromLocalDB<T:Codable>(batchSize : Int,completion: @escaping (Result<T, DataResponseError>) -> Void )
    func postDataToLocalDB<T:Codable, V:Codable>(With entities : T, completion: @escaping (Result<V, DataResponseError>) -> Void)
}
