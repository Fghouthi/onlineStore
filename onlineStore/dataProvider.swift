//
//  dataProvider.swift
//  onlineStore
//
//  Created by aaa on 2/23/23.
//

import Foundation

class dataProvider {
    
    static let shared = dataProvider()
    
    // amazings
    var names = [String]()
    var prices = [String]()
    var prevPrices = [String]()
    
    // only digi
    var onlyPrices = [String]()
    var onlynNames = [String]()
    
    // best saller
    var bestSallerPrices = [String]()
    var bestSallerNames = [String]()
    
    // newest
    var newestPrices = [String]()
    var newestNames = [String]()
    
    var showAllPrices = [String]()
    var showAllNames = [String]()
    
     func setValues(whichCollection: Int ,value: Products) {
        switch whichCollection {
        case 0:
            names.append(value.name)
            prices.append(value.price)
            prevPrices.append(value.prevPrice)
        case 1:
            onlyPrices.append(value.price)
            onlynNames.append(value.name)
        case 2:
            bestSallerPrices.append(value.price)
            bestSallerNames.append(value.name)
        case 3:
            newestPrices.append(value.price)
            newestNames.append(value.name)
        default:
            break
        }
    }
    
    func clearValues(whichCollection: Int) {
        switch whichCollection {
        case 0:
            names.removeAll()
            prices.removeAll()
            prevPrices.removeAll()
        case 1:
            onlyPrices.removeAll()
            onlynNames.removeAll()
        case 2:
            bestSallerPrices.removeAll()
            bestSallerNames.removeAll()
        case 3:
            newestPrices.removeAll()
            newestNames.removeAll()
        default:
            break
        }
    }
}
