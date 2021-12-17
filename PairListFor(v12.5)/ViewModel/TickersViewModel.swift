//
//  PairsViewModel.swift
//  PairListBtc
//
//  Created by İbrahim Demirci on 8.12.2021.
//

import Foundation


struct TickersTableViewModel{
    let TickersList : [Ticker]
}
extension TickersTableViewModel{
    func numberOfRowsInSection() -> Int{
        return self.TickersList.count
    }
    
    func tickerAtIndexPath(_ index: Int) -> TickerViewModel{
        let ticker = self.TickersList[index]
        return TickerViewModel(ticker: ticker)
    }
}

struct TickerViewModel{
    let ticker : Ticker
    
}



