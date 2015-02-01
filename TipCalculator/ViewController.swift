//
//  ViewController.swift
//  TipCalculator
//
//  Created by Vamshedhar on 27/01/15.
//  Copyright (c) 2015 Vamshedhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var totalTextField: UITextField!
    @IBOutlet var taxPctSlider: UISlider!
    @IBOutlet var taxPctLabel: UILabel!
    @IBOutlet var minTipPctFeild: UITextField!
    @IBOutlet var totalResultsFeild: UITextField!
    @IBOutlet var commonDifferenceFeild: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let tipCal = TipCalculatorModel(total: 123.0, taxPct: 1.0)
    
    var possibleTips = Dictionary<Double, (tipAmt:Double, total:Double)>()
    var sortedKeys:[Double] = []
    
    func refreshUI(){
        totalTextField.text = "123.0"
        
        taxPctSlider.value = 1.0
        
        taxPctLabel.text = "Tax Percentage(1%):"
        
        minTipPctFeild.text = "1"
        
        commonDifferenceFeild.text = "1.0"
        
        totalResultsFeild.text = "0"
        
        clearResults()
    }
    
    func clearResults(){
        tipCal.total = Double((totalTextField.text as NSString).doubleValue)
        
        let minTipPct = Double((minTipPctFeild.text as NSString).doubleValue)
        
        let commonDiff = Double((commonDifferenceFeild.text as NSString).doubleValue)
        
        let totalResults = Int((totalResultsFeild.text as NSString).intValue)
        
        possibleTips = tipCal.returnPossibleTips(minTipPct, commonDiff: commonDiff, totalResults: totalResults)
        
        sortedKeys = sorted(Array(possibleTips.keys))
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int((totalResultsFeild.text as NSString).intValue)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value2, reuseIdentifier: nil)
        
        let tipPct = sortedKeys[indexPath.row]
        
        let tipAmt = possibleTips[tipPct]!.tipAmt
        let total = possibleTips[tipPct]!.total
        
        cell.textLabel?.text = "\(tipPct)%:"
        cell.detailTextLabel?.text = String(format: "Tip: $%0.2f. Total: $%0.2f", tipAmt,total)
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshUI()
    }

    @IBAction func clearTapped(sender: AnyObject) {
        refreshUI()
    }
    
    @IBAction func calculateTapped(sender: AnyObject) {
        
        tipCal.total = Double((totalTextField.text as NSString).doubleValue)

        let minTipPct = Double((minTipPctFeild.text as NSString).doubleValue)

        let commonDiff = Double((commonDifferenceFeild.text as NSString).doubleValue)
        
        let totalResults = Int((totalResultsFeild.text as NSString).intValue)

        possibleTips = tipCal.returnPossibleTips(minTipPct, commonDiff: commonDiff, totalResults: totalResults)
        
        sortedKeys = sorted(Array(possibleTips.keys))
        
        tableView.reloadData()
        
    }
    
    @IBAction func taxPercentageChanged(sender: AnyObject) {
        tipCal.taxPct = Double(taxPctSlider.value)/100
        let taxPctStr = String(format: "%0.2f",tipCal.taxPct*100)
        taxPctLabel.text = "Tax Percent (\(taxPctStr))%"
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        totalTextField.resignFirstResponder()
        minTipPctFeild.resignFirstResponder()
        commonDifferenceFeild.resignFirstResponder()
        totalResultsFeild.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

