//
//  HTTPRequest.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/5/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
import Alamofire
//T : Passed object , V : Result object
func doPost <T: Codable,V:Codable>(url: String,object:T,completion: @escaping (Result<V, DataResponseError>) -> Void){
    AF.request(url,method: .post,parameters: object,encoder: JSONParameterEncoder.default,requestModifier: { $0.timeoutInterval = 5 }).responseJSON { (response) -> Void in
        switch response.result{
                case .success(_ ):
                    let jsonParser = JsonParser<V>()
                    if let parsedObject = jsonParser.parseObjectJson(jsonData: response.data!){
                        completion(Result.success(parsedObject))
                    }else{
                        completion(Result.failure(DataResponseError.decoding))
                    }
                    case.failure(_):
                        print("network error with status code \(String(describing: response.response?.statusCode))")
                        completion(Result.failure(DataResponseError.network))
                }
        }
}

func doGet <T: Codable>(url: String,parameters : Parameters , page: Int ,completion: @escaping (Result<T, DataResponseError>) -> Void){
    let parameters = ["page": "\(page)"].merging(parameters, uniquingKeysWith: +)
    AF.request(url , parameters: parameters,requestModifier: { $0.timeoutInterval = 5 })
        .validate(statusCode: 200..<299)
        .response{(response) -> Void in
            switch response.result{
            case .success( _):
                let jsonParser = JsonParser<T>()
                if let parsedObject = jsonParser.parseObjectJson(jsonData: response.data!){
                    completion(Result.success(parsedObject))
                }else{
                    completion(Result.failure(DataResponseError.decoding))
                }
          case.failure(_):
                   completion(Result.failure(DataResponseError.network))
            }
        
    }
}
