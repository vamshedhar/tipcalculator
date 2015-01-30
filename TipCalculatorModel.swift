//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by Vamshedhar on 27/01/15.
//  Copyright (c) 2015 Vamshedhar. All rights reserved.
//

import Foundation

class TipCalculatorModel{
    var total: Double
    var taxPct: Double
    var subtotal: Double{
        get{
            return total/(taxPct + 1)
        }
    }
    
    init(total: Double, taxPct: Double){
        self.total = total
        self.taxPct = taxPct
    }
    
    func calculateTipWithPct(tipPct: Double) -> (tipAmt:Double, total:Double){
        return (subtotal * tipPct, total + subtotal*tipPct)
    }
    
    func returnPossibleTips(minTipPct: Double, commonDiff: Double, totalResults:Int) -> [Double: (tipAmt:Double,total:Double)]{
        
        var retval = Dictionary<Double,(tipAmt:Double, total:Double)>()
        
        var tipPct = minTipPct
        
        for i in 0..<totalResults{
            
            retval[tipPct] = calculateTipWithPct(tipPct/100)
            
            tipPct += commonDiff
        }
        
        return retval
    }
}