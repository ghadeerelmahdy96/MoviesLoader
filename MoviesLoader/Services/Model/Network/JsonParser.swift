//
//  HTTPResponse.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/5/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
struct  JsonParser<T: Codable>{

    func parseArrayOfJson(jsonData: Data)->[T]? {
        var parcedData : [T]? = nil
        do{
            parcedData = try? JSONDecoder().decode([T].self, from: jsonData)
        }
        return parcedData
    }
    
    func parseObjectJson(jsonData: Data)->T?{
        var parcedData : T? = nil
        do{
            parcedData = try? JSONDecoder().decode(T.self, from: jsonData)
        }
        return parcedData
    }
}
