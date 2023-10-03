//
//  ApiService.swift
//  iOSPoc
//
//  Created by Lakshmikanth on 02/10/23.
//

import Foundation
class ApiService {
    private init() {}
    static let shared = ApiService()
    static let baseURL = "https://api.thecatapi.com/v1/"
    fileprivate var gateway: Gateway = HttpGateway(baseURL)
    func fetchCatImages(completion: @escaping (_ result: [CatImageResponse]?, _ error: String?) -> ()) {
        gateway.REQUEST("get", "images/search?limit=10&breed_ids=beng", parameters: nil) { data, error in
            let decoder = JSONDecoder()

            if let data = data {
                do{
                    
                    let tasks = try decoder.decode([CatImageResponse].self, from: data)
    //                tasks.forEach{ i in
                        print(tasks)
                    completion(tasks, error?.localizedDescription)
    //                }
                }catch{
                    print(error)
                }
            }
            
        //    self.handle(objectClass: T.self, response: data, error: error, completion: completion)
        }
    }
    func handle<O: Codable>(objectClass: O.Type, response: Data?, error: Error?, completion handler: (_ result: O?, _ error: String?) -> Void) {
        handle(objectClass: objectClass, errorClass: APIError.self, response: response, error: error, completion: handler)
    }
    func handle<O: Codable, E: CodableBaseError>(objectClass: O.Type, errorClass: E.Type, response: Data?, error: Error?, completion handler: (_ result: O?, _ error: String?) -> Void) {
        //Success with no body
        if response == nil && error == nil {
            handler(nil, nil)
            return
        }
        
        //Deserialize for error
        if let error = error {
            
            //Unauthenticated Error
            if error.localizedDescription.contains("401") || error.localizedDescription.contains("403") {
                print("Unauth notification sent")
                return
            }
            
            
            handler(nil, error.localizedDescription)
            return
        }
        
        //Deserialize for success
        let decoder = JSONDecoder()
        if let data = response, let string = String(data: data, encoding: .utf8){
            print(string)
        }
        if let data = response {
            do{
                
                let tasks = try decoder.decode([O].self, from: data)
//                tasks.forEach{ i in
                    print(tasks)
//                }
            }catch{
                print(error)
            }
        }
        //Failed to deserialize
        handler(nil, "Unable to read server response.")
    }
    func deserialize<T: Codable>(_ objectClass: T.Type, _ response: Data) -> T? {
        guard response.count > 0 else {
            return nil
        }
        
        //Attempt JSON
        do {
            let jsonData = try JSONSerialization.jsonObject(with: response, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            let jsonString = String(data: response, encoding: .utf8)
            //debugPrint("jsonData----: \(jsonData)")
            return try JSONDecoder().decode(T.self, from: response)
        } catch {
            print(error)
        }
        return nil
    }
}
