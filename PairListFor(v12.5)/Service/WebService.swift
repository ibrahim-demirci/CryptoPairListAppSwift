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

    
    func getTickers(isFirstRequest : Bool , completion: @escaping ([Ticker]?) -> (),whenError: @escaping (Error?) -> ()){
        
        URLSession.shared.dataTask(with: isFirstRequest ? urlFail! : url!) { data, response, error in
            if error != nil{
                print("ERROR İÇERİSİNDE")
                whenError(error)
                
            }else {
                print("ERROR GELMEDİ")
                if let data = data{
                    
                    if data.isEmpty{
                        print("EMPTY")
                        whenError(error)
                    }else {
                        if let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any]{
                            
                            let root = Root(json: json)
                            
                            if let data = root!.data{
                                completion(data)
                                
                            }
                        }
                        
                    }
                    
                } else{
                    print("DATA NIL")
                    whenError(error)
                }
                
            }

        }.resume()
    }
}
