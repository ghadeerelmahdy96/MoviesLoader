//
//  HTTPRequest.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/5/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
import Alamofire

func doPost <T: Codable, V: Codable>(url: String,object:T, _ completionHandler: @escaping(V)->(), _ errorHandler: @escaping (String)->()){
    AF.request(url,method: .post,parameters: object,encoder: JSONParameterEncoder.default,requestModifier: { $0.timeoutInterval = 5 }).responseJSON{ (response) -> Void in
        switch response.result{
                case .success( _):
                    let jsonParser = JsonParser<V>()
                    if let parsedObject = jsonParser.parseObjectJson(jsonData: response.data!){
                        completionHandler(parsedObject)
                    }else{
                        errorHandler("JSON_PARSING_ERROR")
                          print(".error")
                    }
                    case.failure(let error):
                        errorHandler("FETCH_DATA_ERROR_WITH_CODE" + " \(String(describing: error.responseCode))")
                }
        }
}

func doGet <T: Codable>(url: String, _ completionHandler: @escaping(T)->(), _ errorHandler: @escaping (String)->()){
    AF.request(url, requestModifier: { $0.timeoutInterval = 5 } ).validate()
        .response{(response) -> Void in
            switch response.result{
            case .success( _):
                let jsonParser = JsonParser<T>()
                if let parsedObject = jsonParser.parseObjectJson(jsonData: response.data!){
                    completionHandler(parsedObject)
                }else{
                    errorHandler("JSON_PARSING_ERROR")
                }
          case.failure(let error):
                    errorHandler("FETCH_DATA_ERROR" + " \(error.localizedDescription)")
            }
    }
}
