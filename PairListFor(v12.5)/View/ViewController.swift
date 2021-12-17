//
//  ViewController.swift
//  PairListBtc
//
//  Created by İbrahim Demirci on 7.12.2021.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    private var isFirstRequest = true
    private var tickersTableViewModel : TickersTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showSpinner()
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "PairTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "pairCell")
        
        updateButtonBorders()
        getTickers()
    }
    
    func updateButtonBorders(){
        for i in 1..<6{
            if let button = view.viewWithTag(i) as? UIButton {
                button.layer.cornerRadius = 8
                button.titleEdgeInsets = UIEdgeInsets(top: 4, left: 7, bottom: 4, right: 7)
            }
        }
    }
    
    // Get tickers from api
    func getTickers(){
        WebService().getTickers(isFirstRequest: isFirstRequest) { response in
            if let response = response {
                 
                self.isFirstRequest = !self.isFirstRequest
                if let data = response.data{
                    self.tickersTableViewModel = TickersTableViewModel(TickersList: data)
                }
                DispatchQueue.main.async {
                    self.removeSpinner()
                    self.tableView.reloadData()
                }
            }
        } whenError: { error in
            DispatchQueue.main.async {
                self.isFirstRequest = !self.isFirstRequest
                self.removeSpinner()
                self.alertMessage(title: "Fail", message: "Fail to load data")
            }
        }
    }
    
    // Show alert dialog
    func alertMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let tryAgainButton = UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) { alertAction in
            self.getTickers()
        }
        alert.addAction(tryAgainButton)
        self.present(alert, animated: true,completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickersTableViewModel == nil ? 0 : self.tickersTableViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pairCell", for: indexPath) as! PairTableViewCell
        let tickerViewModel = self.tickersTableViewModel.tickerAtIndexPath(indexPath.row)
        updateCellVariables(ticker: tickerViewModel.ticker,cell: cell)
        
        return cell
    }
    
    func updateCellVariables(ticker: Ticker, cell: PairTableViewCell){
        if let numerator = ticker.numeratorSymbol{
            cell.numeratorText.text = numerator
        }
        if let last = ticker.last{
            cell.lastText.text = "₺\(last)"
        }
        if let dailyPercent = ticker.dailyPercent{
            cell.dailyPercentText.text = "%\(dailyPercent)"
        }
        let volumeString = ticker.volumeString()
        cell.volumeText.text = volumeString
    }
}

