//
//  WebService.swift
//  PairListBtc
//
//  Created by İbrahim Demirci on 7.12.2021.
//

import Foundation




class WebService {
    
    let url = URL(string: "https://api.btcturk.com/api/v2/ticker/currency?symbol=TRY")
    let urlFail = URL(string: "https://api.btcturk.com/api/v2/ticker/currenc?symbol=TRY")
    
    func getTickers(isFirstRequest : Bool , completion: @escaping (TickerResponse?) -> (),whenError: @escaping (Error?) -> ()){
        
        
         URLSession.shared.dataTask(with: isFirstRequest ? urlFail! : url!) { (data, response, error) in
            
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 404 {
                        whenError(error)
                    }
                    else if httpResponse.statusCode == 200 {
                        if let data = data {
                            if let tickerResponse = try? JSONDecoder().decode(TickerResponse.self, from: data){
                                completion(tickerResponse)
                            }
                        }
                    }
                }
    }.resume()
        
//        URLSession.shared.dataTask(with: isFirstRequest ? urlFail! : url!) { data, response, error in
//            if error != nil{
//                whenError(error)
//            }
//            else {
//                if let data = data{
//                     if data.isEmpty{
//                        whenError(error)
//                    }
//                     else {
//                        if let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any]{
//                            let root = Root(json: json)
//                            if let data = root!.data{
//                                completion(data)
//                            }
//                        }
//                    }
//                }
//                else{
//                    print("DATA NIL")
//                    whenError(error)
//                }
//            }
//        }.resume()
    }
}
