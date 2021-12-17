//
//  Ticker.swift
//  PairListBtc
//
//  Created by İbrahim Demirci on 7.12.2021.
//

import Foundation


struct Root  {
    
    let data : [Ticker]?
    let success: Bool?
    let message : String?
    let code : Int?
    
    init?(json : [String : Any]){
        self.success = json["success"] as? Bool
        self.message = json["message"] as? String
        self.code = json["code"] as? Int
        
        var tickerArray =  [Ticker]()
        if let tickers = json["data"] as? [[String:Any]]{
            
            for tickerItem in tickers{
                let ticker = Ticker(json: tickerItem)
                tickerArray.append(ticker)
                
            }
        self.data = tickerArray
        } else {
            self.data = nil
        }
    }
    
}

struct Ticker {
    
    let pair : String?
    let last : Double?
    let numeratorSymbol: String?
    let denumeratorSymbol: String?
    let dailyPercent : Double?
    
    init(json : [String:Any]){
        
        self.pair = json["pair"] as? String ?? nil
        self.last = json["last"] as? Double ?? nil
        self.numeratorSymbol = json["numeratorSymbol"] as? String ?? nil
        self.denumeratorSymbol = json["denominatorSymbol"] as? String ?? nil
        self.dailyPercent = json["dailyPercent"] as? Double ?? nil

        
    }
    
}

    
