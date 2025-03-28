//
//  Service.swift
//  PrecoBitcoin
//
//  Created by Jean Ramalho on 28/03/25.
//
import Foundation
import UIKit

class Service {
    
    let url = URL(string: "https://blockchain.info/ticker")
    
    let task = URLSession.shared.dataTask(with: url) { data, httpResponse, error in
        <#code#>
    }
}
